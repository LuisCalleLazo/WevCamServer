namespace WebCamServer.Services.Interfaces
{
  public interface IDetectIAService
  {
    string DetectFacePose(string imagePath);
    bool CompareEmbeddings(string embedding, string[] references);
    Task<string> GenerateEmbeddingAsync(string imagePath);
  }
}