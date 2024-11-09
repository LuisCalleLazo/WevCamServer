
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;

namespace WebCamServer.Config
{
  public static class LoadServiceAuth
  {
    public static void ConfigureAuth(this IServiceCollection services, WebApplicationBuilder builder)
    {
      var jwtConfig = builder.Configuration.GetSection("JwtConfig");
      
      services.AddAuthentication( conf =>
        {
          conf.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
          conf.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
        })
        .AddJwtBearer(op => 
        {
          op.RequireHttpsMetadata = false;
          op.SaveToken = true;
          op.TokenValidationParameters = new TokenValidationParameters
          {
            ValidateIssuer = false,
            ValidateAudience = false,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ClockSkew = TimeSpan.Zero,
            ValidIssuer = jwtConfig["Issuer"],
            ValidAudience = jwtConfig["Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtConfig["Key"]))
          };
        }
      );

    }
  }
}