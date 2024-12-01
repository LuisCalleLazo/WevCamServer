using Grpc.Net.Client;
using WebCamServer.Protos;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Services
{
  public class GrpcClient : IGrpcClient
  {
    private readonly FaceService.FaceServiceClient _client;

    public GrpcClient()
    {
      var channel = GrpcChannel.ForAddress("http://localhost:50051");
      _client = new FaceService.FaceServiceClient(channel);
    }

    public async Task<string> DetectFacePose(string imagePath)
    {
      var request = new DetectFaceRequest { ImagePath = imagePath };
      var response = await _client.DetectFacePoseAsync(request);
      return response.Result;
    }

    public async Task<bool> GenerateModel(string nameModel, string typeSave, string folderPath)
    {
      var request = new GenerateModelRequest
      {
        NameModel = nameModel,
        TypeSave = typeSave,
        FolderPath = folderPath
      };
      var response = await _client.GenerateModelAsync(request);
      return response.Success;
    }
  }
}