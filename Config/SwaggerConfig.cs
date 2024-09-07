using Microsoft.OpenApi.Models;

namespace WebCamServer.Config
{
  
  public static class ServiceExtenstionSwagger
  {
    public static void ConfigureSwagger(this IServiceCollection services)
    {
      services.AddSwaggerGen(c =>
        {
          c.SwaggerDoc("v1", new OpenApiInfo { Title = "Auth Service API", Version = "v1" });
          
          c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
          {
            Description = @"JWT Authorization header using the Bearer scheme. <br /> <br />
                          Enter 'Bearer' [space] and then your token in the text input below.<br /> <br />
                          Example: 'Bearer 12345abcdef'<br /> <br />",
            Name = "Authorization",
            In = ParameterLocation.Header,
            Type = SecuritySchemeType.ApiKey,
            Scheme = "Bearer"
          });

          c.AddSecurityRequirement(new OpenApiSecurityRequirement()
          {
            {
              new OpenApiSecurityScheme
              {
                Reference = new OpenApiReference
                  {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                  },
                  Scheme = "oauth2",
                  Name = "Bearer",
                  In = ParameterLocation.Header,
                },
                new List<string>()
              }
            });
      });
    }
  }
}