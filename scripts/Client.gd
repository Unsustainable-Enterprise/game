extends Node2D

export var message_path: NodePath
onready var message_node: Node = get_node(message_path)

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
				message_node.create_lobby_response(json.result)
			web_socket_events.JOINED_LOBBY:
				message_node.create_lobby_response(json.result)
			web_socket_events.PARTICIPANT_JOINED_LOBBY:
				message_node.create_lobby_response(json.result)
			_:
				print("Unknown event with data: ", json.result)

func send(json):
	print(json)
	_client.get_peer(1).put_packet(JSON.print(json).to_utf8())
