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

    private void OnConnected()
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

            switch (jsonData["event"])
            {
                case WebSocketEvent.CREATE_PARTY:
                    Receive
                        .Lobby()
                        .CreateParty(JsonConvert.DeserializeObject<ReceiveCreateParty>(data));
                    break;
                case WebSocketEvent.JOIN_LOBBY:
                    // ReceiveMessage.Call("JoinLobby", json.Result);
                    break;
                // case WebSocketEvents.PARTICIPANT_JOINED_LOBBY:
                //     ReceiveMessage.Call("ParticipantJoinedLobby", json.Result);
                //     break;
                // case WebSocketEvents.LEAVE_LOBBY:
                //     ReceiveMessage.Call("LeaveLobby", json.Result);
                //     break;
                // case WebSocketEvents.START_GAME:
                //     ReceiveMessage.Call("StartGame");
                //     break;
                // case WebSocketEvents.DISPLAY_QUESTION_RESULTS:
                //     ReceiveMessage.Call("DisplayQuestionResults", json.Result);
                //     break;
                // case WebSocketEvents.ANSWER_QUESTION:
                //     ReceiveMessage.Call("AnswerQuestion", json.Result);
                //     break;
                default:
                    throw new Exception("Unknown event");
            }
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
