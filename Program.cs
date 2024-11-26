
using WebCamServer.Config;
using WebCamServer.Helpers;
using WebCamServer.Services;

var builder = WebApplication.CreateBuilder(args);

// builder.WebHost.ConfigureKestrel(serverOptions =>
// {
//   serverOptions.Listen(System.Net.IPAddress.Any, 5000);  // HTTP
// });

builder.Services.Configure<CloudinarySettings>
  (builder.Configuration.GetSection("CloudinarySettings"));

// TODO: Controladores
builder.Services.AddControllers();
builder.Services.AddAutoMapper(typeof(AuthService).Assembly);

// TODO: Habilitando los Cors
string MyAllowSpecificOrigins = "AllowAnyOrigin";
builder.Services.ConfigureCors(MyAllowSpecificOrigins);

// TODO: Cargando la injeccion de dependencias
LoadService.LoadServices(builder.Services);
LoadService.LoadRepositories(builder.Services);


// TODO: Habilitando el contexto de la base de datos
builder.Services.ConfigureContext(builder);
  
// TODO: Endpoints
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// TODO: Swagger with google authentication
builder.Services.ConfigureSwagger();

// TODO: Configuracion de autenticación
builder.Services.ConfigureAuth(builder);

var app = builder.Build();


// TODO: Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
  app.UseSwagger();
  app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseWebSockets();;

app.UseRouting();
app.UseCors(MyAllowSpecificOrigins);
 
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();

app.Run();