
using Microsoft.Extensions.Options;
using MongoDB.Driver;
using WebCamServer.Helpers;

namespace WebCamServer.Config
{
  public static class ServiceExtenstionContext
  {
    public static void ConfigureContext(this IServiceCollection services, WebApplicationBuilder builder)
    {
      services.Configure<MongoDbSettings>(builder.Configuration.GetSection("MongoDbSettings"));
      services.AddSingleton<IMongoClient, MongoClient>(sp => 
      {
        var settings = sp.GetRequiredService<IOptions<MongoDbSettings>>().Value;
        return new MongoClient(settings.ConnectionString);
      });


      services.AddDistributedMemoryCache(); // Agrega caché en memoria para las sesiones

      services.AddSession(options =>
      {
        options.IdleTimeout = TimeSpan.FromMinutes(30); // Tiempo que las sesiones permanecen activas
        options.Cookie.HttpOnly = true;
        options.Cookie.IsEssential = true;
      });
    }
  }
}