extends Node2D

var SOCKET_URL = "wss://localhost:3000"
var _client = WebSocketClient.new()


func _ready():
	_client.connect("connection_closed", self, "_on_connection_closed")
	_client.connect("connection_error", self, "_on_connection_closed")
	_client.connect("connection_established", self, "_on_connected")
	_client.connect("data_received", self, "_on_data")

	var err = _client.connect_to_url(SOCKET_URL)
	if err != OK:
		print("Unable to connect")
		set_process(false)


func _process(delta):
	_client.poll()


func _on_connection_closed(was_clean = false):
	print("Closed. clean:", was_clean)
	set_process(false)


func _on_connected(protocol = ""):
	print("Connected with protocol :", protocol)
	_send()


func _on_data():
	print("Received data : ", _client.get_peer(1).get_packet().get_string_from_utf8())


func _send():
	print("Hello World")
	var json = {
		"event": "create_lobby",
		"message":
		{
			"data":
			{"name": "Name", "scenario": "scenario", "totalQuestions": 10, "winPercentage": 51}
		}
	}
	_client.get_peer(1).put_packet(JSON.print(json).to_utf8())
