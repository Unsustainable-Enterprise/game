extends Node2D

export var message_path: NodePath

onready var message_node: Node = get_node(message_path)

var URL = "wss://localhost:3000"
var _client = WebSocketClient.new()

signal web_socket_ready

func _ready():
	_client.connect("connection_closed", self, "_on_connection_closed")
	_client.connect("connection_error", self, "_on_connection_closed")
	_client.connect("connection_established", self, "_on_connected")
	_client.connect("data_received", self, "_on_data")

	var err = _client.connect_to_url(URL)
	if err != OK:
		print("Unable to connect")
		set_process(false)
	


func _process(delta):
	_client.poll()


func _on_connection_closed(was_clean = false):
	print("Closed. clean:", was_clean)
	set_process(false)


func _on_connected(_protocol):
	emit_signal("web_socket_ready")


func _on_data():
	print("Received data : ", _client.get_peer(1).get_packet().get_string_from_utf8())


func send(json):
	print(json)
	_client.get_peer(1).put_packet(JSON.print(json).to_utf8())
