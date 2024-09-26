

using WebCamServer.Repositories;
using WebCamServer.Repositories.Interfaces;
using WebCamServer.Services;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Config
{
  public static class LoadService
  {
    public static void LoadRepositories(IServiceCollection services)
    {
      services.AddScoped<IUserRepository, UserRepository>();
      services.AddScoped<ITokenRepository, TokenRepository>();
      services.AddScoped<ICameraRepository, CameraRepository>();
      services.AddScoped<ICameraHomeRepository, CameraHomeRepository>();
      services.AddScoped<ICameraActivityRepository, CameraActivityRepository>();
      services.AddScoped<IRecordingRepository, RecordingRepository>();
    }

    public static void LoadServices(IServiceCollection services)
    {
      services.AddScoped<IAuthService, AuthService>();
      services.AddScoped<IDetectIAService, DetectIAService>();
      services.AddScoped<ICameraService, CameraService>();
      services.AddScoped<IControlsService, ControlsService>();
      services.AddScoped<IUserService, UserService>();
    }
  }
}