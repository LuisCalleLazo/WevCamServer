
using System.Diagnostics;
using WebCamServer.Helpers;
using WebCamServer.Repositories.Interfaces;
using WebCamServer.Services.Interfaces;
namespace WebCamServer.Services
{
  public class DetectIAService : IDetectIAService
  {
    private readonly IUserRepository _userRepo;
    public DetectIAService(IUserRepository userRepo)
    {
      _userRepo = userRepo;
    }

    public string DetectFacePose(string imagePath)
    {
      string pythonExePath = "python";
      string scriptPath = Path.Combine(Directory.GetCurrentDirectory(), ConstantsValueSystem.NameFolderPython(), "DetectFace/detect_face_pose.py");

      var psi = new ProcessStartInfo
      {
        FileName = pythonExePath,
        Arguments = $"{scriptPath} {imagePath}",
        RedirectStandardOutput = true,
        UseShellExecute = false
      };
      using (Process process = Process.Start(psi))
      {
        using (StreamReader reader = process.StandardOutput)
        {
          string result = reader.ReadToEnd();
          return result.Trim();
        }
      }
    }
    
    // ToDo: Realizar compracion de embeddings con FaceNet     
    public bool CompareEmbeddings(string embedding, string[] references)
    {
      return true;
    }

    // ToDo: Realizar Generacion de Embeddings con FaceNet de todas las imagenes obtenidas
    public async Task<string> GenerateEmbeddingAsync(string imagePath)
    {
      return string.Empty;
    }

  }
}