

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
      services.AddScoped<ICommentRepository, CommentRepository>();
      services.AddScoped<IVideoPublicationRepository, VideoPublicationRepository>();
      services.AddScoped<IAdminRepository, AdminRepository>();
      services.AddScoped<IFoundVideoRepository, FoundVideoRepository>();
      services.AddScoped<IMissingRepository, MissingRepository>();
      services.AddScoped<INotificationRepository, NotificationRepository>();
      services.AddScoped<ISeekerRepository, SeekerRepository>();
      services.AddScoped<IContactsRepository, ContactsRepository>();

    }

    public static void LoadServices(IServiceCollection services)
    {
      services.AddScoped<IAuthService, AuthService>();
      services.AddScoped<IDetectIAService, DetectIAService>();
      services.AddScoped<ICameraService, CameraService>();
      services.AddScoped<IUserService, UserService>();
      services.AddScoped<INotificationService, NotificationService>();
      services.AddScoped<IMissingService, MissingService>();
      services.AddScoped<IFileService, FileService>();

      // Algoritmo de colas
      services.AddSingleton<TaskQueue>();
      // Ejecucion en segundo plano
      services.AddHostedService<AnalysisBackgroundService>();
    }
  }
}