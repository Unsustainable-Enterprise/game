extends Control

onready var data_manager: Node = get_node("/root/DataManager")

export var participant_names_path: NodePath
onready var participant_names: RichTextLabel = get_node(participant_names_path)


func _ready():
	var participants = data_manager.get_participants()
	for name in participants:
		participant_names.text += name + "\n"


