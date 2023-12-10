extends Node

var user_name setget set_user_name, get_user_name

var token setget set_token, get_token

var participants setget set_participants, get_participants

var is_host setget set_is_host, get_is_host

var pin setget set_pin, get_pin

func set_user_name(name):
	user_name = name

func get_user_name():
   return user_name

func set_token(lobby_token):
	token = lobby_token
	print(token)

func get_token():
   return token

func set_participants(participant_names):
	participants = participant_names
	print(participants)

func get_participants():
   return participants

func set_is_host(value):
	is_host = value

func get_is_host():
   return is_host

func set_pin(value):
	pin = value

func get_pin():
   return pin

func clear_all():
	user_name = ""
	token = ""
	participants = []
	is_host = false
	pin = ""