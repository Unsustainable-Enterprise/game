using System.Collections.Generic;
using Godot;

public class DataManager : Node2D
{
    public string UserName { get; set; }
    public string Token { get; set; }
    public List<string> Participants { get; set; }
    public bool IsHost { get; set; }
    public int Pin { get; set; }
    public int CurrentQuestion { get; set; }
    public string Scenario { get; set; }

    public void ClearAll()
    {
        UserName = "";
        Token = "";
        Participants = new List<string>();
        IsHost = false;
        Pin = 0;
        CurrentQuestion = 0;
    }
}
