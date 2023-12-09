extends Control

onready var data_manager: Node = get_node("/root/DataManager")

export var participant_names_path: NodePath
onready var participant_names: RichTextLabel = get_node(participant_names_path)

export var start_lobby_path: NodePath
onready var start_lobby: Button = get_node(start_lobby_path)

export var exit_lobby_path: NodePath
onready var exit_lobby: Button = get_node(exit_lobby_path)

func _ready():
	if data_manager.get_is_host():
		start_lobby.visible = true
	else:
		start_lobby.visible = false

	var participants = data_manager.get_participants()
	for name in participants:
		participant_names.text += name + "\n"

func _on_exit_lobby_pressed():
	pass # Replace with function body.


func _on_start_lobby_pressed():
	pass # Replace with function body.
