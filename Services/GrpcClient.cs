using Grpc.Net.Client;
using MongoDB.Driver;
using WebCamServer.Helpers;
using WebCamServer.Protos;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Services
{
  public class GrpcClient : IGrpcClient
  {
    private readonly IConfiguration _config;
    private readonly FaceService.FaceServiceClient _client;
    private readonly PredictService.PredictServiceClient _clientPredict;

    public GrpcClient(IConfiguration config)
    {
      _config = config;
      string iaServiceValue = _config.GetValue<string>("IaService");
      var channel = GrpcChannel.ForAddress(iaServiceValue);
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

    public async Task<ResultPredictionType> PredictFace(string imagePath, int idMissing)
    {

      var request = new PredictFaceRequest
      {
        ImagePath = imagePath,
      };

      var response = await _clientPredict.PredictFaceAsync(request);

      switch (response.Result)
      {
        case 0:
          return ResultPredictionType.Nothing;
        case 1:
          return ResultPredictionType.Found;
        case 2:
          return ResultPredictionType.NotFound;
        default:    
          return ResultPredictionType.Nothing;
      }  
    }

    public async Task<List<FaceDetection>> PredictFaceMultiple(string folderPath, int idMissing)
    {
      var request = new PredictFaceMultipleRequest
      {
        FolderPath = folderPath,
      };

      var response = await _clientPredict.PredictFaceMultipleAsync(request);

      var faceDetections = response.DateRanges.Select(dateRange =>
      {
        var date = DateOnly.Parse(dateRange.InitDate);
        var startTime = TimeOnly.Parse(dateRange.InitDate);
        var endTime = TimeOnly.Parse(dateRange.EndDate);

        return new FaceDetection
        {
          Date = date,
          StartTime = startTime,
          EndTime = endTime
        };
      }).ToList();

      return faceDetections;
    }
  }
}