extends Node

var client_node = null

func create_lobby():
	var createJson = {
		"event": "create_lobby",
		"message": {
			"data": {
				"name": "Name",
				"scenario": "scenario",
				"totalQuestions": 10,
				"winPercentage": 51
			}
		}
	}
	get_parent().send(createJson)


# func join_lobby():
# 	print("join_lobby")


# func send_message():
# 	print("send_message")

func _ready():
	# warning-ignore:return_value_discarded
	get_parent().connect("web_socket_ready", self, "_on_web_socket_ready")
		

func _on_web_socket_ready():
	create_lobby()
	
