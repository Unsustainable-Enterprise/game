extends Node

onready var data_manager: Node = get_node("/root/DataManager")

func create_lobby(data: Dictionary):
	add_data_manager(data.token, data.message.user_name, [data.message.user_name], true, data.message.pin)

	if get_tree().change_scene("res://scenes/Lobby.tscn") != OK:
		print ("An unexpected error occured when trying to switch scenes")

func join_lobby(data: Dictionary):
		add_data_manager(data.token, data.message.user_name, data.message.participants, false)
		
		if get_tree().change_scene("res://scenes/Lobby.tscn") != OK:
			print ("An unexpected error occured when trying to switch scenes")

func participant_joined_lobby(data: Dictionary):
	data_manager.set_participants(data.message.participants)
	if(get_tree().current_scene.name == "Lobby"):
		get_tree().get_root().get_node("Lobby").update_participants()

func leave_lobby():
	data_manager.set_token("")
	data_manager.set_user_name("")
	data_manager.set_participants([])
	data_manager.set_is_host(false)
	print("left lobby")

func add_data_manager(token: String, user_name: String, participants: Array, is_host: bool, pin: String = ""):
	if(is_host):
		data_manager.set_pin(pin)

	data_manager.set_token(token)
	data_manager.set_user_name(user_name)
	data_manager.set_participants(participants)
	data_manager.set_is_host(is_host)

