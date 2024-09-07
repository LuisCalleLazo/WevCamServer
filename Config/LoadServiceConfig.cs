


using WebCamServer.Repositories;
using WebCamServer.Services;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Config
{
  public static class LoadServiceCors
  {
    public static void LoadRepositories(IServiceCollection services)
    {
      services.AddScoped<UserRepository>();
    }

    public static void LoadServices(IServiceCollection services)
    {
      services.AddScoped<IAuthService, AuthService>();
    }
  }
}