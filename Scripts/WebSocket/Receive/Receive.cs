using Godot;

public class Receive : Node
{
    [Export]
    private NodePath LobbyPath = new NodePath();
    private ReceiveLobby ReceiveLobby;

    public override void _Ready()
    {
        ReceiveLobby = GetNode<ReceiveLobby>(LobbyPath);
    }

    public ReceiveLobby Lobby() => ReceiveLobby;
}
