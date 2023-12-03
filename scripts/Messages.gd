extends Node

var client_node = null

func create_lobby(user_name, scenario, win_percentage):
	var createJson = {
		"event": "create_lobby",
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


# func join_lobby():
# 	print("join_lobby")


# func send_message():
# 	print("send_message")

