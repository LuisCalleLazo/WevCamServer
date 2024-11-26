
using System.Diagnostics;
using WebCamServer.Helpers;
using WebCamServer.Repositories.Interfaces;
using WebCamServer.Services.Interfaces;
namespace WebCamServer.Services
{
  public class DetectIAService : IDetectIAService
  {
    private readonly IUserRepository _userRepo;
    private string pythonExePath = "python";
    public DetectIAService(IUserRepository userRepo)
    {
      _userRepo = userRepo;
    }

    public async Task<string> DetectFacePose(string imagePath)
    {
      string scriptPath = Path.Combine(
        Directory.GetCurrentDirectory(), 
        ConstantsValueSystem.NameFolderPython(), 
        "DetectFace/detect_face_pose.py"
      );

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
          string result = await reader.ReadToEndAsync();
          return result.Trim();
        }
      }
    }
    public async Task<bool> GenerateModel(string nameModel, string typeSave, string folderPath)
    {
      string scriptPath = Path.Combine(
        Directory.GetCurrentDirectory(), 
        ConstantsValueSystem.NameFolderPython(), 
        "PredictionFace/face_model.py");

      var psi = new ProcessStartInfo
      {
        FileName = pythonExePath,
        Arguments = $"{scriptPath} {nameModel} {typeSave} {folderPath}",
        RedirectStandardOutput = true,
        UseShellExecute = false
      };
      using (Process process = Process.Start(psi))
      {
        using (StreamReader reader = process.StandardOutput)
        {
          string result = await reader.ReadToEndAsync();
          Console.WriteLine(result);
          return result.Trim() == "True" ? true : false;
        }
      }
    }

    public async Task<ResultPredictionType> PredictFace(string image_path, string path_model)
    {
      string scriptPath = Path.Combine(
        Directory.GetCurrentDirectory(), 
        ConstantsValueSystem.NameFolderPython(), 
        "PredictionFace/prediction_face.py");

      var psi = new ProcessStartInfo
      {
        FileName = pythonExePath,
        Arguments = $"{scriptPath} {image_path} {path_model}",
        RedirectStandardOutput = true,
        UseShellExecute = false
      };
      using (Process process = Process.Start(psi))
      {
        using (StreamReader reader = process.StandardOutput)
        {
          string result = await reader.ReadToEndAsync();
          switch (result)
          {
            case "0":
              return ResultPredictionType.Nothing;
            case "1":
              return ResultPredictionType.Found;
            case "2":
              return ResultPredictionType.NotFound;
            default:
              return ResultPredictionType.Nothing;
          }
        }
      }
    }

  }
}