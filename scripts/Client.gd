extends Node2D

export var send_message_path: NodePath
onready var send_message: Node = get_node(send_message_path)

export var receive_message_path: NodePath
onready var receive_message: Node = get_node(receive_message_path)

var paths = load("res://configs/Paths.gd")

var web_socket_events = load("res://scripts/WebSocketEvents.gd")

var URL = "wss://localhost:3000"
var _client = WebSocketClient.new()

signal web_socket_ready

func _ready():
	print(web_socket_events)
	_client.connect("connection_closed", self, "_on_connection_closed")
	_client.connect("connection_error", self, "_on_connection_closed")
	_client.connect("connection_established", self, "_on_connected")
	_client.connect("data_received", self, "_on_data")

	var err = _client.connect_to_url(URL)
	if err != OK:
		print("Unable to connect")
		set_process(false)
	
func _process(_delta):
	_client.poll()

func _on_connection_closed(was_clean = false):
	print("Closed. clean:", was_clean)
	set_process(false)

func _on_connected(_protocol):
	emit_signal("web_socket_ready")

func _on_data():
	print(web_socket_events.CREATE_LOBBY)
	var data = _client.get_peer(1).get_packet().get_string_from_utf8()
	print("Received data : ", data)
	var json = JSON.parse(data)
	if json.error == OK:
		match json.result.event:
			web_socket_events.CREATE_LOBBY:
				receive_message.create_lobby(json.result)
			web_socket_events.JOIN_LOBBY:
				receive_message.join_lobby(json.result)
			web_socket_events.PARTICIPANT_JOINED_LOBBY:
				receive_message.participant_joined_lobby(json.result)
			web_socket_events.LEAVE_LOBBY:
				receive_message.leave_lobby(json.result)
			_:
				print("Unknown event with data: ", json.result)

func send(json):
	print(json)
	_client.get_peer(1).put_packet(JSON.print(json).to_utf8())
