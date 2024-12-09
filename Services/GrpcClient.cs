using Grpc.Net.Client;
using WebCamServer.Protos;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Services
{
  public class GrpcClient : IGrpcClient
  {
    private readonly FaceService.FaceServiceClient _client;
    private readonly PredictService.PredictServiceClient _clientPredict;

    public GrpcClient()
    {
      var channel = GrpcChannel.ForAddress("http://localhost:5001");
      _client = new FaceService.FaceServiceClient(channel);
      _clientPredict = new PredictService.PredictServiceClient(channel);
    }

    public async Task<string> DetectFacePose(string imagePath)
    {
      var request = new DetectFaceRequest { ImagePath = imagePath };
      var response = await _client.DetectFacePoseAsync(request);
      return response.Result;
    }

    public async Task<bool> GenerateModel(string nameModel, string typeSave, string folderPath, int idMissing)
    {
      var request = new GenerateModelRequest
      {
        NameModel = nameModel,
        TypeSave = typeSave,
        FolderPath = folderPath,
        IdMissing = idMissing
      };
      var response = await _clientPredict.GenerateModelAsync(request);
      return response.Success;
    }
  }
}