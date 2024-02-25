using System.Collections.Generic;
using Godot;

public class DataManager : Node2D
{
    public string UserName { get; private set; }
    public string Token { get; private set; }
    public List<string> Participants { get; set; }
    public bool IsHost { get; private set; }
    public string Pin { get; private set; }
    public int CurrentQuestion { get; private set; } = 0;
    public string Scenario { get; private set; }

    public void ClearAll()
    {
        UserName = "";
        Token = "";
        Participants = new List<string>();
        IsHost = false;
        Pin = "";
        CurrentQuestion = 0;
    }

    public void AddDataManager(
        string token,
        string userName,
        List<string> participants,
        bool isHost,
        string scenario,
        string pin = ""
    )
    {
        Token = token;
        UserName = userName;
        Participants = participants;
        IsHost = isHost;
        Scenario = scenario;
        Pin = pin;
    }
}
