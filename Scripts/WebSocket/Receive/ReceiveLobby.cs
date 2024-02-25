using System.Collections.Generic;
using Godot;

public class ReceiveLobby
{
    private DataManager _dataManager;
    private SceneManager _sceneManager;

    public ReceiveLobby(DataManager dataManager, SceneManager sceneManager)
    {
        _dataManager = dataManager;
        _sceneManager = sceneManager;
    }

    public void CreateParty(ReceiveBase<CreatePartyMessage> data)
    {
        _dataManager.AddDataManager(
            data.Token,
            data.Message.UserName,
            new List<string>(),
            true,
            data.Message.Scenario,
            data.Message.Pin
        );

        _sceneManager.ChangeScene(Scene.Lobby);
    }

    public void JoinLobby(ReceiveBase<JoinPartyMessage> data)
    {
        _dataManager.AddDataManager(
            data.Token,
            data.Message.UserName,
            data.Message.Participants,
            false,
            data.Message.Scenario
        );

        _sceneManager.ChangeScene(Scene.Lobby);
    }

    public void ParticipantJoinedLobby(ReceiveBase<ParticipantJoinedMessage> data)
    {
        _dataManager.Participants = new List<string> { data.Message.Participants };

        if (_sceneManager.GetSceneName() == Scene.Lobby.ToString())
        {
            // Update lobby names
        }
    }

    public void LeaveParty(ReceiveBase<LeaveParty> data)
    {
        if (data.Message.IsHost)
        {
            _dataManager.ClearAll();
            _sceneManager.ChangeScene(Scene.StartMenu);
        }
        else
        {
            _dataManager.Participants = data.Message.Participants;
            if (_sceneManager.GetSceneName() == Scene.Lobby.ToString())
            {
                // Update lobby names
            }
        }
    }
}
