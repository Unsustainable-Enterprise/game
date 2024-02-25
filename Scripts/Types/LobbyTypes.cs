using Newtonsoft.Json;

public class ReceiveCreateParty
{
    [JsonProperty("event")]
    public string Event { get; set; }

    [JsonProperty("token")]
    public string Token { get; set; }

    [JsonProperty("message")]
    public ReceiveCreatePartyMessage Message { get; set; }
}

public class ReceiveCreatePartyMessage
{
    [JsonProperty("pin")]
    public string Pin { get; set; }

    [JsonProperty("user_name")]
    public string UserName { get; set; }

    [JsonProperty("scenario")]
    public string Scenario { get; set; }
}
