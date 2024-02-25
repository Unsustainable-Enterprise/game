using System.Collections.Generic;
using Godot;

public class ReceiveLobby : Node
{
    private Node dataManager;

    // public override void _Ready()
    // {
    //     dataManager = GetNode<DataManager>("/root/DataManager");
    // }

    public void CreateParty(ReceiveCreateParty data)
    {
        GD.Print(data.Event);
        GD.Print(data.Token);
        GD.Print(data.Message.UserName);
        // AddDataManager(
        //     (string)data["token"],
        //     (string)data["message.user_name"],
        //     new List<string> { (string)data["message.user_name"] },
        //     true,
        //     (string)data["message.scenario"],
        //     (int)data["message.pin"]
        // );

        // if (GetTree().ChangeScene("res://scenes/Lobby.tscn") != Error.Ok)
        // {
        //     GD.Print("An unexpected error occured when trying to switch scenes");
        // }
    }

    public void JoinLobby(Dictionary<string, object> data)
    {
        AddDataManager(
            (string)data["token"],
            (string)data["message.user_name"],
            (List<string>)data["message.participants"],
            false,
            (string)data["message.scenario"]
        );

        if (GetTree().ChangeScene("res://scenes/Lobby.tscn") != (int)Godot.Error.Ok)
        {
            GD.Print("An unexpected error occured when trying to switch scenes");
        }
    }

    public void ParticipantJoinedLobby(Dictionary<string, object> data)
    {
        dataManager.Call("SetParticipants", data["message.participants"]);
        if (GetTree().CurrentScene.Name == "Lobby")
        {
            GetTree().Root.GetNode("Lobby").Call("UpdateParticipants");
        }
    }

    public void LeaveLobby(Dictionary<string, object> data)
    {
        dataManager.Call("ClearAll");
        if ((bool)data["message.is_host"])
        {
            if (GetTree().ChangeScene("res://scenes/StartMenu.tscn") != (int)Godot.Error.Ok)
            {
                GD.Print("An unexpected error occured when trying to switch scenes");
            }
        }
        else
        {
            dataManager.Call("SetParticipants", data["message.participants"]);
            if (GetTree().CurrentScene.Name == "Lobby")
            {
                GetTree().Root.GetNode("Lobby").Call("UpdateParticipants");
            }
        }
    }

    private void AddDataManager(
        string token,
        string userName,
        List<string> participants,
        bool isHost,
        string scenario,
        int pin = 0
    )
    {
        // Implement your logic here to add data to the data manager node
    }
}
