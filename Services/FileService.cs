using WebCamServer.Dtos;
using WebCamServer.Helpers;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Services
{
  public class FileService : IFileService
  {

    public FileService()
    {

    }

    public async Task UploadLocalFile(MissingToSaveDto save)
    {
      var path = Path.Combine(Directory.GetCurrentDirectory(), $"Missing/{save.UserId}/{save.MissingId}/{save.Type}", save.NameFile);

      Directory.CreateDirectory(Path.GetDirectoryName(path));

      try
      {
        // Intenta guardar el archivo sin sobrescribir si ya existe
        using (var stream = new FileStream(path, FileMode.CreateNew))
        {
          await save.File.CopyToAsync(stream);
        }
      }
      catch (IOException)
      {
        // Manejo en caso de que el archivo ya exista
        Console.WriteLine("El archivo ya existe. Cambie el nombre o maneje el conflicto según sea necesario.");
      }
    }
  }
}