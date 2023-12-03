extends Control

onready var web_socket_manager: Node = get_node("/root/WebSocketManager")

export var scenario_path: NodePath
onready var scenario_selector: OptionButton = get_node(scenario_path)

export var win_pct_slider_text_path: NodePath
onready var win_pct_slider_text: Label = get_node(win_pct_slider_text_path)

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

export var error_message_path: NodePath
onready var error_message_text: Label = get_node(error_message_path)

var user_name: String
var scenario: String
var win_percentage: float


func _ready():
	add_scenario_options()
	create_lobby_canvas.visible = false


func add_scenario_options():
	scenario_selector.add_item("Hello")
	scenario_selector.add_item("World")
	scenario_selector.select(-1)
	scenario_selector.text = "Select Scenario"


# func _ready():
# 	#warning-ignore:return_value_discarded
# 	get_parent().connect("web_socket_ready", self, "_on_web_socket_ready")


func _on_OptionButton_item_selected(index:int):
	if(index != -1):
		scenario = scenario_selector.get_item_text(index)
	else:
		print('no scenario selected')


func _on_LineEdit_text_changed(new_text:String):
	if(new_text.length() != 0):
		user_name = new_text
	else:
		print('empty name')


func _on_HostBtn_pressed():
	host_btn.visible = false;
	join_btn.visible = false;
	create_lobby_canvas.visible = true;


func _on_CreateLobbyBtn_pressed():
	if(user_name.length() == 0):
		error_message_text.text = "Please enter a name"
	elif(scenario.length() == 0):
		error_message_text.text = "Please select a scenario"
	else:
		web_socket_manager.message_node.create_lobby(user_name, scenario, win_percentage)


func _on_WinPercentageSlider_value_changed(value:float):
	win_pct_slider_text.text = str(win_pct_slider.value) + "%"
	win_percentage = value
