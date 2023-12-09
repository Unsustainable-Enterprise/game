extends Node

onready var data_manager: Node = get_node("/root/DataManager")

func create_lobby(data):
	print("create_lobby_response")
	print(data)
	add_data_manager(data.token, data.message.user_name, [data.message.user_name], true, data.message.pin)
	if get_tree().change_scene("res://scenes/Lobby.tscn") != OK:
		print ("An unexpected error occured when trying to switch scenes")

func join_lobby(data):
		print("join_lobby_response")
		print(data)
		add_data_manager(data.token, data.message.user_name, data.message.participants, false)
		if get_tree().change_scene("res://scenes/Lobby.tscn") != OK:
			print ("An unexpected error occured when trying to switch scenes")

func participant_joined_lobby(data):
	print("participant_joined_lobby")
	print(data)

func add_data_manager(token, user_name, participants, is_host, pin = ""):
	data_manager.set_token(token)
	data_manager.set_user_name(user_name)
	data_manager.set_participants(participants)
	data_manager.set_is_host(is_host)
	if(is_host):
		data_manager.set_pin(pin)