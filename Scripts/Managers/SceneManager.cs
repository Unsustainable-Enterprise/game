using Godot;

public enum Scene
{
    StartMenu,
    Lobby,
    Game,
}

public class SceneManager : Node2D
{
    public void ChangeScene(Scene scene)
    {
        GetTree().ChangeScene($"res://scenes/{scene}.tscn");
    }

    public string GetSceneName()
    {
        return GetTree().CurrentScene.Name;
    }
}
