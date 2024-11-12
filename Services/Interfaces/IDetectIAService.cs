using WebCamServer.Helpers;

namespace WebCamServer.Services.Interfaces
{
  public interface IDetectIAService
  {
    Task<string> DetectFacePose(string imagePath);
    Task<bool> GenerateModel(string nameModel, string typeSave, string folderPath);
    Task<ResultPredictionType> PredictFace(string image_path, string path_model);
  }
}