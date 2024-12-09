namespace WebCamServer.Services.Interfaces
{
  public interface IGrpcClient
  {
    Task<string> DetectFacePose(string imagePath);
    Task<bool> GenerateModel(string nameModel, string typeSave, string folderPath, int idMissing);
  }
}