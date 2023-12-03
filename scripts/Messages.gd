extends Node

var web_socket_events = load("res://scripts/WebSocketEvents.gd")

func create_lobby(user_name: String, scenario: String, win_percentage: float) -> void:
	var createJson = {
		"event": web_socket_events.CREATE_LOBBY,
		"message": {
			"data": {
				"name": user_name,
				"scenario": scenario,
				"totalQuestions": 10,
				"winPercentage": win_percentage
			}
		}
	}
	get_parent().send(createJson)

func create_lobby_response(data):
	print("create_lobby_response")
	print(data)


func join_lobby(user_name: String, pin: String) -> void:
	var joinJson = {
		"event": web_socket_events.JOIN_LOBBY,
		"message": {
			"data": {
				"name": user_name,
				"pin": pin
			}
		}
    }
	get_parent().send(joinJson)


# func send_message():
# 	print("send_message")

