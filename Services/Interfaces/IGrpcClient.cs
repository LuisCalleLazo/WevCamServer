using WebCamServer.Helpers;

namespace WebCamServer.Services.Interfaces
{
  public interface IGrpcClient
  {
    Task<string> DetectFacePose(string imagePath);
    Task<bool> GenerateModel(string nameModel, string typeSave, string folderPath, int idMissing);
    Task<ResultPredictionType> PredictFace(string imagePath, int idMissing);
    Task<List<FaceDetection>> PredictFaceMultiple(string folderPath, int idMissing);
  }
}