using CSRedis;
using System.IO;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.Extensions.Hosting;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using WaterCloud.Code;
using WaterCloud.Code.Model;
using System.Text.Encodings.Web;
using System.Text.Unicode;
using Newtonsoft.Json.Serialization;
using WaterCloud.Service.AutoJob;
using WaterCloud.DataBase;
using System.Reflection;
using System.Linq;
using WaterCloud.Service;
using Autofac;
using Microsoft.AspNetCore.Mvc;
using Quartz;
using Quartz.Impl;
using Quartz.Spi;
using System;
using Chloe.Infrastructure.Interception;
using Microsoft.Extensions.FileProviders;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.ResponseCompression;
using System.IO.Compression;
using WaterCloud.Domain.SystemOrganize;
using Microsoft.OpenApi.Models;
using System.Collections.Generic;

namespace WaterCloud.Web
{
	public class Startup
    {
        public IConfiguration Configuration { get; }
        public IWebHostEnvironment WebHostEnvironment { get; set; }
        public Startup(IConfiguration configuration, IWebHostEnvironment env)
        {
            Configuration = configuration;
            WebHostEnvironment = env;
            GlobalContext.LogWhenStart(env);
            GlobalContext.HostingEnvironment = env;
        }
        // This method gets called by the runtime. Use this method to add services to the container.
        public async void ConfigureServices(IServiceCollection services)
        {
			GlobalContext.SystemConfig = Configuration.GetSection("SystemConfig").Get<SystemConfig>();
			GlobalContext.Services = services;
			GlobalContext.Configuration = Configuration;
			services.AddSwaggerGen(config =>
			{
				config.SwaggerDoc("v1", new OpenApiInfo { Title = "WaterCloud Api", Version = "v1" });
				var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
				var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
				config.IncludeXmlComments(xmlPath, true); //添加控制器层注释（true表示显示控制器注释）
				config.AddSecurityDefinition(GlobalContext.SystemConfig.TokenName, new OpenApiSecurityScheme
				{
					Description = "header token",
					Name = GlobalContext.SystemConfig.TokenName,
					In = ParameterLocation.Header,
					Scheme = "",
					Type = SecuritySchemeType.ApiKey,//设置类型
					BearerFormat = ""
				});
				config.AddSecurityRequirement(new OpenApiSecurityRequirement
				{
					{
						new OpenApiSecurityScheme
						{
							Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = GlobalContext.SystemConfig.TokenName }
						},
						new List<string>()
					}
				});
			});
			services.AddSession();
            //代替HttpContext.Current
            services.AddHttpContextAccessor();
            //缓存缓存选择
            if (Configuration.GetSection("SystemConfig:CacheProvider").Value!= Define.CACHEPROVIDER_REDIS)
            {
                services.AddMemoryCache();
            }
            else
            {
                //redis 注入服务
                string redisConnectiong = Configuration.GetSection("SystemConfig:RedisConnectionString").Value;
                // 多客户端 1、基础 2、操作日志
                var redisDB1 = new CSRedisClient(redisConnectiong + ",defaultDatabase=" + 0);
                BaseHelper.Initialization(redisDB1);
                var redisDB2 = new CSRedisClient(redisConnectiong + ",defaultDatabase=" + 1);
                HandleLogHelper.Initialization(redisDB2);
                services.AddSingleton(redisDB1);
                services.AddSingleton(redisDB2);
            }
            //连续guid初始化,示例IDGenerator.NextId()
            services.AddSingleton<IDistributedIDGenerator, SequentialGuidIDGenerator>();
            #region 依赖注入
            //注入数据库连接
            services.AddScoped<Chloe.IDbContext>((serviceProvider) =>
            {
                return DBContexHelper.Contex();
            });
            #region 注入 Quartz调度类
            services.AddSingleton<JobExecute>();
            //注册ISchedulerFactory的实例。
            services.AddSingleton<ISchedulerFactory, StdSchedulerFactory>();
            services.AddSingleton<IJobFactory, IOCJobFactory>();
            //是否开启后台任务
			if (Configuration.GetSection("SystemConfig:OpenQuarz").Value == "True")
			{
                services.AddHostedService<JobCenter>();
            }
            #endregion
            //注入SignalR实时通讯，默认用json传输
            services.AddSignalR(options =>
            {
                //客户端发保持连接请求到服务端最长间隔，默认30秒，改成4分钟，网页需跟着设置connection.keepAliveIntervalInMilliseconds = 12e4;即2分钟
                options.ClientTimeoutInterval = TimeSpan.FromMinutes(4);
                //服务端发保持连接请求到客户端间隔，默认15秒，改成2分钟，网页需跟着设置connection.serverTimeoutInMilliseconds = 24e4;即4分钟
                options.KeepAliveInterval = TimeSpan.FromMinutes(2);
            });
            ////注册html解析
            //services.AddSingleton(HtmlEncoder.Create(UnicodeRanges.All));
            ////注册特性
            //services.AddScoped<HandlerLoginAttribute>();
            //services.AddScoped<HandlerAuthorizeAttribute>();
            ////ajax不能使用注入
            ////services.AddScoped<HandlerAjaxOnlyAttribute>();
            //services.AddScoped<HandlerAdminAttribute>();
            #endregion
            services.AddCors(options => options.AddPolicy("CorsPolicy",
            builder =>
            {
                builder.AllowAnyMethod().AllowAnyHeader()
                       .WithOrigins(Configuration.GetSection("SystemConfig:AllowCorsSite").Value.Split(","))
                       .AllowCredentials();
            }));
            services.AddHttpClient();
            services.AddControllersWithViews(options =>
            {
                options.Filters.Add<GlobalExceptionFilter>();
                options.Filters.Add<ModelActionFilter>();
                options.ModelMetadataDetailsProviders.Add(new ModelBindingMetadataProvider());
                //options.Filters.Add(new AutoValidateAntiforgeryTokenAttribute());
            }).AddNewtonsoftJson(options =>
            {
                // 返回数据首字母不小写，CamelCasePropertyNamesContractResolver是小写
                options.SerializerSettings.ContractResolver = new DefaultContractResolver();
            }).AddControllersAsServices().AddRazorRuntimeCompilation();
			services.AddDirectoryBrowser();
			services.AddControllers(options =>
			{
				options.Filters.Add<ModelActionFilter>();
				options.ModelMetadataDetailsProviders.Add(new ModelBindingMetadataProvider());
			}).ConfigureApiBehaviorOptions(options =>
			{
				options.SuppressModelStateInvalidFilter = true;
			});
			services.AddAntiforgery(options => options.HeaderName = "X-CSRF-TOKEN");
            //启用 Gzip 和 Brotil 压缩功能
            services.AddResponseCompression(options =>
            {
                options.Providers.Add<BrotliCompressionProvider>();
                options.Providers.Add<GzipCompressionProvider>();
                options.MimeTypes =
                    ResponseCompressionDefaults.MimeTypes.Concat(
                        new[] { "image/svg+xml" });
            });

            services.Configure<BrotliCompressionProviderOptions>(options =>
            {
                options.Level = (CompressionLevel)4; // 4 or 5 is OK
            });
            services.AddOptions();
            services.AddDataProtection().PersistKeysToFileSystem(new DirectoryInfo(GlobalContext.HostingEnvironment.ContentRootPath + Path.DirectorySeparatorChar + "DataProtection"));
            //更新数据库管理员和主系统
            try
            {
                if (GlobalContext.SystemConfig.ReviseSysem == true)
                {
                    using (var context = DBContexHelper.Contex())
                    {
						var setentity = context.Query<SystemSetEntity>().FirstOrDefault();
						context.Session.BeginTransaction();
						var user = context.Query<UserEntity>().Where(a => a.F_Account == setentity.F_AdminAccount).FirstOrDefault();
						var userinfo = context.Query<UserLogOnEntity>().Where(a => a.F_UserId == user.F_Id).FirstOrDefault();
						userinfo.F_UserSecretkey = Md5.md5(Utils.CreateNo(), 16).ToLower();
						userinfo.F_UserPassword = Md5.md5(DESEncrypt.Encrypt(Md5.md5(GlobalContext.SystemConfig.SysemUserPwd, 32).ToLower(), userinfo.F_UserSecretkey).ToLower(), 32).ToLower();
						context.Update<UserEntity>(a => a.F_Id == user.F_Id, a => new UserEntity
						{
							F_Account = GlobalContext.SystemConfig.SysemUserCode
						});
                        var cacheKeyUser = "watercloud_userdata_";
						await CacheHelper.Remove(cacheKeyUser + user.F_Id);
						await context.UpdateAsync<UserLogOnEntity>(a => a.F_Id == userinfo.F_Id, a => new UserLogOnEntity
						{
							F_UserPassword = userinfo.F_UserPassword,
							F_UserSecretkey = userinfo.F_UserSecretkey
						});
						await context.UpdateAsync<SystemSetEntity>(a => a.F_Id == userinfo.F_Id, a => new SystemSetEntity
						{
							F_AdminAccount = GlobalContext.SystemConfig.SysemUserCode,
							F_AdminPassword = GlobalContext.SystemConfig.SysemUserPwd
						});
						context.Session.CommitTransaction();
						var cacheKeyOperator = "watercloud_operator_";// +登录者token
						await CacheHelper.Remove(cacheKeyOperator + "info_" + user.F_Id);
					}
                }
            }
            catch (Exception ex)
            {
                LogHelper.Write(ex);
            }
            //清理缓存
            //CacheHelper.FlushAll().GetAwaiter().GetResult();
        }
        //AutoFac注入
        public void ConfigureContainer(ContainerBuilder builder)
        {
            var assemblys = Assembly.Load("WaterCloud.Service");//Service是继承接口的实现方法类库名称
            var baseType = typeof(IDenpendency);//IDenpendency 是一个接口（所有要实现依赖注入的借口都要继承该接口）
            builder.RegisterAssemblyTypes(assemblys).Where(m => baseType.IsAssignableFrom(m) && m != baseType)
              .InstancePerLifetimeScope()//生命周期，这里没有使用接口方式
              .PropertiesAutowired() ;//属性注入
            //Controller中使用属性注入
            var controllerBaseType = typeof(Controller);
            builder.RegisterAssemblyTypes(typeof(Program).Assembly)
            .Where(t => controllerBaseType.IsAssignableFrom(t) && t != controllerBaseType)
            .PropertiesAutowired();
            //注册html解析
            builder.RegisterInstance(HtmlEncoder.Create(UnicodeRanges.All)).SingleInstance();
            //注册特性
            builder.RegisterType(typeof(HandlerLoginAttribute)).InstancePerLifetimeScope();
            builder.RegisterType(typeof(HandlerAuthorizeAttribute)).InstancePerLifetimeScope();
            builder.RegisterType(typeof(HandlerAdminAttribute)).InstancePerLifetimeScope();
            builder.RegisterType(typeof(HandlerLockAttribute)).InstancePerLifetimeScope();
			//ControllerBase中使用属性注入
			controllerBaseType = typeof(ControllerBase);
			builder.RegisterAssemblyTypes(typeof(Program).Assembly)
			.Where(t => controllerBaseType.IsAssignableFrom(t) && t != controllerBaseType)
			.PropertiesAutowired();
			//注册特性
			builder.RegisterType(typeof(AuthorizeFilterAttribute)).InstancePerLifetimeScope();
			builder.RegisterType(typeof(LoginFilterAttribute)).InstancePerLifetimeScope();
		}
        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app)
        {
            //由于.Net Core默认只会从wwwroot目录加载静态文件，其他文件夹的静态文件无法正常访问。
            //而我们希望将图片上传到网站根目录的upload文件夹下，所以需要额外在Startup.cs类的Configure方法中
            string resource = Path.Combine(Directory.GetCurrentDirectory(), "upload");
            if (!FileHelper.IsExistDirectory(resource))
            {
                FileHelper.CreateFolder(resource);
            }
            app.UseStaticFiles(new StaticFileOptions
            {
                FileProvider = new PhysicalFileProvider(resource),
                RequestPath = "/upload",
                OnPrepareResponse = ctx =>
                {
                    ctx.Context.Response.Headers.Append("Cache-Control", "public,max-age=36000");
                }
            });
            app.UseCors("CorsPolicy");
            if (WebHostEnvironment.IsDevelopment())
            {
                //打印sql
                IDbCommandInterceptor interceptor = new DbCommandInterceptor();
                DbInterception.Add(interceptor);
                GlobalContext.SystemConfig.Debug = true;
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error?msg=404");
            }
            //文件地址Resource
            //静态资源wwwroot
            app.UseStaticFiles(new StaticFileOptions
            {
                ContentTypeProvider = new CustomerFileExtensionContentTypeProvider(),
                OnPrepareResponse = GlobalContext.SetCacheControl
            });
			//启用 Gzip 和 Brotil 压缩功能
			app.UseResponseCompression();
			app.Use(next => context =>
			{
				context.Request.EnableBuffering();
				return next(context);
			});
			app.UseSwagger(c =>
			{
				c.RouteTemplate = "api-doc/{documentName}/swagger.json";
			});
			app.UseSwaggerUI(c =>
			{
				c.RoutePrefix = "api-doc";
				c.SwaggerEndpoint("v1/swagger.json", "WaterCloud Api v1");
			});
			//session
			app.UseSession();
			//路径
			app.UseRouting();
            //MVC路由
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapHub<MessageHub>("/chatHub");
                endpoints.MapControllerRoute("areas", "{area:exists}/{controller=Home}/{action=Index}/{id?}");
                endpoints.MapControllerRoute("default", "{controller=Login}/{action=Index}/{id?}");
                // 移动端(钉钉小程序)功能已屏蔽,api约定路由已注释,小程序接口全部失效
				//endpoints.MapControllerRoute("api", "api/{controller=ApiHome}/{action=Index}/{id?}");
			});
            GlobalContext.ServiceProvider = app.ApplicationServices;
        }
    }
}
