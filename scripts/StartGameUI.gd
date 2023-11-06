extends Control

onready var web_socket_manager: Node = get_node("/root/WebSocketManager")

export var scenario_path: NodePath
onready var scenario_selector: OptionButton = get_node(scenario_path)

export var name_input_path: NodePath
onready var name_input: LineEdit = get_node(name_input_path)

export var win_pct_slider_path: NodePath
onready var win_pct_slider: Slider = get_node(win_pct_slider_path)

export var create_lobby_btn_path: NodePath
onready var create_lobby_btn: Button = get_node(create_lobby_btn_path)

export var host_btn_path: NodePath
onready var host_btn: Button = get_node(host_btn_path)

export var join_btn_path: NodePath
onready var join_btn: Button = get_node(join_btn_path)

export var create_lobby_canvas_path: NodePath
onready var create_lobby_canvas: CanvasLayer = get_node(create_lobby_canvas_path)


func _ready():
	add_scenario_options()
	scenario_selector.visible = false
	create_lobby_canvas.visible = false


func add_scenario_options():
	scenario_selector.add_item("Hello")
	scenario_selector.add_item("World")
	scenario_selector.select(-1)
	scenario_selector.set_item_text(-1, "Select option")


func _on_Button_pressed():
	web_socket_manager.message_node.create_lobby()

# func _ready():
# 	#warning-ignore:return_value_discarded
# 	get_parent().connect("web_socket_ready", self, "_on_web_socket_ready")


func _on_OptionButton_item_selected(index:int):
	print(index)
	print(scenario_selector.get_item_text(index))


func _on_WinPercentageSlider_drag_ended(value_changed:bool):
	pass # Replace with function body.


func _on_LineEdit_text_changed(new_text:String):
	pass # Replace with function body.


func _on_HostBtn_pressed():
	host_btn.visible = false;
	create_lobby_canvas.visible = true;
