extends Control

onready var web_socket_manager: Node = get_node("/root/WebSocketManager")

func _on_Button_pressed():
	web_socket_manager.message_node.create_lobby()

# func _ready():
	# warning-ignore:return_value_discarded
	#get_parent().connect("web_socket_ready", self, "_on_web_socket_ready")