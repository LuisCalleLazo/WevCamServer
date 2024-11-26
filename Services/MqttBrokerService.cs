using MQTTnet;
using MQTTnet.Server;
using MQTTnet.Client;
using MQTTnet.Client.Options;
using System.Text;

namespace WebCamServer.Services
{
  public class MqttBrokerService
  {
    private readonly IMqttServer _mqttServer;
    private IMqttClient _mqttClient;

    public MqttBrokerService()
    {
      var factory = new MqttFactory();
      _mqttServer = factory.CreateMqttServer();
      _mqttClient = factory.CreateMqttClient();
    }

    public async Task StartAsync()
    {
      var options = new MqttServerOptionsBuilder()
          .WithDefaultEndpoint()
          .WithDefaultEndpointPort(1883) // Puerto para conexiones MQTT
          .Build();

      // Manejador de conexión de clientes
      _mqttServer.UseClientConnectedHandler(async e =>
      {
          Console.WriteLine($"Cliente conectado: {e.ClientId}");
          await Task.CompletedTask;
      });

      // Manejador de mensajes recibidos
      _mqttServer.UseApplicationMessageReceivedHandler(e =>
      {
        string topic = e.ApplicationMessage.Topic;
        string payload = Encoding.UTF8.GetString(e.ApplicationMessage.Payload);

        Console.WriteLine($"Mensaje recibido: Topic: {topic}, Payload: {payload}");
      });

      await _mqttServer.StartAsync(options);

      // Conectar el cliente MQTT
      var clientOptions = new MqttClientOptionsBuilder()
          .WithTcpServer("localhost", 1883) // Cambia esto si tu broker está en otro lugar
          .Build();

      await _mqttClient.ConnectAsync(clientOptions);
      Console.WriteLine("Cliente MQTT conectado al broker.");
    }

    public async Task StopAsync()
    {
      await _mqttClient.DisconnectAsync();
      await _mqttServer.StopAsync();
      Console.WriteLine("Broker MQTT detenido.");
    }

    public async Task PublishMessageAsync(string topic, string message)
    {
      var mqttMessage = new MqttApplicationMessageBuilder()
          .WithTopic(topic)
          .WithPayload(message)
          .WithExactlyOnceQoS()
          .WithRetainFlag()
          .Build();

      await _mqttClient.PublishAsync(mqttMessage);
      Console.WriteLine($"Mensaje publicado: Topic: {topic}, Payload: {message}");
    }
  }
}