using System.Collections.Generic;
using Newtonsoft.Json;

public class ReceiveBase<T>
{
    [JsonProperty("event")]
    public string Event { get; set; }

    [JsonProperty("token")]
    public string Token { get; set; }

    [JsonProperty("message")]
    public T Message { get; set; }
}

public class CreatePartyMessage
{
    [JsonProperty("pin")]
    public string Pin { get; set; }

    [JsonProperty("user_name")]
    public string UserName { get; set; }

    [JsonProperty("scenario")]
    public string Scenario { get; set; }
}

public class JoinPartyMessage
{
    [JsonProperty("scenario")]
    public string Scenario { get; set; }

    [JsonProperty("user_name")]
    public string UserName { get; set; }

    [JsonProperty("participants")]
    public List<string> Participants { get; set; }
}

public class ParticipantJoinedMessage
{
    [JsonProperty("participants")]
    public string Participants { get; set; }
}

public class LeaveParty
{
    [JsonProperty("is_host")]
    public bool IsHost { get; set; }

    [JsonProperty("participants")]
    public List<string> Participants { get; set; }
}
