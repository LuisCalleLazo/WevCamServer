namespace WebCamServer.Config
{
  public static class CorsConfig
  {
    public static void ConfigureCors(this IServiceCollection services, string policyName)
    {
      services.AddCors(options =>
      {
        options.AddPolicy(
          name: policyName,
          builder =>
          {
            builder.AllowAnyOrigin()
                    .AllowAnyMethod()
                    .AllowAnyHeader();
          });
      });
    }
  }
}