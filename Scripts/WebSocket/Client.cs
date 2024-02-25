using System;
using System.Collections.Generic;
using Godot;
using Newtonsoft.Json;

public class Client : Node2D
{
    [Export]
    private NodePath ReceievePath = new NodePath();
    public Receive Receive;

    private string wsUrl = "wss://localhost:3000";
    private WebSocketClient _client = new WebSocketClient();

    [Signal]
    delegate void WebSocketReady();

    public override void _Ready()
    {
        Receive = GetNode<Receive>(ReceievePath);
        _client.Connect("connection_closed", this, nameof(OnConnectionClosed));
        _client.Connect("connection_error", this, nameof(OnConnectionClosed));
        _client.Connect("connection_established", this, nameof(OnConnected));
        _client.Connect("data_received", this, nameof(OnData));

        Error err = _client.ConnectToUrl(wsUrl);

        if (err != Error.Ok)
        {
            GD.Print("Unable to connect");
            SetProcess(false);
        }
    }

    public override void _Process(float delta)
    {
        _client.Poll();
    }

    private void OnConnectionClosed(bool wasClean = false)
    {
        GD.Print("Closed. Clean:", wasClean);
        SetProcess(false);
    }

    private void OnConnected(string protocol)
    {
        GD.Print("Connected to ");
        EmitSignal("WebSocketReady");
    }

    private void OnData()
    {
        try
        {
            string data = _client.GetPeer(1).GetPacket().GetStringFromUTF8();
            GD.Print("Received data : ", data);

            Dictionary<string, object> jsonData = JsonConvert.DeserializeObject<
                Dictionary<string, object>
            >(data);

            if (jsonData.ContainsKey("event") == false)
            {
                GD.Print("No event key found in JSON data");
                return;
            }

            Receive.ProcessEvent((string)jsonData["event"], data);
        }
        catch (Exception ex)
        {
            GD.Print("Failed to deserialize JSON data:", ex.Message);
            return;
        }
    }

    private void Send(object json)
    {
        GD.Print(json);
        _client.GetPeer(1).PutPacket(JSON.Print(json).ToUTF8());
    }
}
