extends Node

onready var data_manager: Node = get_node("/root/DataManager")

func create_lobby(data):
	print("create_lobby_response")
	print(data)

func join_lobby(data):
		print("join_lobby_response")
		print(data)
		data_manager.set_token(data.token)
		data_manager.set_user_name(data.message.user_name)
		data_manager.set_participants(data.message.participants)
		if get_tree().change_scene("res://scenes/Lobby.tscn") != OK:
			print ("An unexpected error occured when trying to switch scenes")

func participant_joined_lobby(data):
	print("participant_joined_lobby")
	print(data)