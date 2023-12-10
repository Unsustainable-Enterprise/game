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

func leave_lobby() -> void:
	var leftJson = {
		"event": web_socket_events.LEAVE_LOBBY,
	}
	get_parent().send(leftJson)