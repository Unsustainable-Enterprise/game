using Godot;
using Newtonsoft.Json;

public class Receive : Node
{
    private DataManager _dataManager;
    private SceneManager _sceneManager;

    private ReceiveParty ReceiveLobby;

    public override void _Ready()
    {
        _dataManager = GetNode<DataManager>(Paths.DataManager);
        _sceneManager = GetNode<SceneManager>(Paths.SceneManager);

        ReceiveLobby = new ReceiveParty(_dataManager, _sceneManager);
    }

    public ReceiveParty Lobby() => ReceiveLobby;

    public void ProcessEvent(string wsEvent, string data)
    {
        switch (wsEvent)
        {
            case WebSocketEvent.CreateParty:
                Lobby()
                    .CreateParty(
                        JsonConvert.DeserializeObject<ReceiveBase<CreatePartyMessage>>(data)
                    );
                break;
            case WebSocketEvent.JoinParty:
                Lobby()
                    .JoinLobby(JsonConvert.DeserializeObject<ReceiveBase<JoinPartyMessage>>(data));
                break;
            case WebSocketEvent.ParticipantJoinedParty:
                Lobby()
                    .ParticipantJoinedLobby(
                        JsonConvert.DeserializeObject<ReceiveBase<ParticipantJoinedMessage>>(data)
                    );
                break;
            case WebSocketEvent.LeaveParty:
                Lobby().LeaveParty(JsonConvert.DeserializeObject<ReceiveBase<LeaveParty>>(data));
                break;
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
                return;
        }
    }
}
