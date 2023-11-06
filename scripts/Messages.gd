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

func create_lobby_response(data):
	print("create_lobby_response")
	print(data)


# func join_lobby():
# 	print("join_lobby")


# func send_message():
# 	print("send_message")

