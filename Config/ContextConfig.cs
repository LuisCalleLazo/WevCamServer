using Microsoft.EntityFrameworkCore;
using WebCamServer.Database;

namespace WebCamServer.Config
{
  public static class ServiceExtenstionContext
  {
    public static void ConfigureContext(this IServiceCollection services, WebApplicationBuilder builder)
    {

      string host = builder.Configuration.GetConnectionString("MongoHost");
      string db = builder.Configuration.GetConnectionString("MongoDb");
      
      services.AddDbContext<DataContext>(options => 
      {
        options.UseMongoDB(host, db);
      });

      // services.AddDistributedMemoryCache(); // Agrega caché en memoria para las sesiones

      // services.AddSession(options =>
      // {
      //   options.IdleTimeout = TimeSpan.FromMinutes(30); // Tiempo que las sesiones permanecen activas
      //   options.Cookie.HttpOnly = true;
      //   options.Cookie.IsEssential = true;
      // });
    }
  }
}