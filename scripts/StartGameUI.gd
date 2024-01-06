extends Control

onready var web_socket_manager: Node = get_node("/root/WebSocketManager")
onready var paths = web_socket_manager.paths

export var scenario_path: NodePath
onready var scenario_selector: OptionButton = get_node(scenario_path)

export var win_pct_slider_text_path: NodePath
onready var win_pct_slider_text: Label = get_node(win_pct_slider_text_path)

export var name_input_path: NodePath
onready var name_input: LineEdit = get_node(name_input_path)

export var pin_input_parth: NodePath
onready var pin_input: LineEdit = get_node(pin_input_parth)

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

export var join_lobby_canvas_path: NodePath
onready var join_lobby_canvas: CanvasLayer = get_node(join_lobby_canvas_path)

export var error_message_create_path: NodePath
onready var error_message_create: Label = get_node(error_message_create_path)

export var error_message_join_path: NodePath
onready var error_message_join: Label = get_node(error_message_join_path)

onready var files_manager = load(paths.FILE_MANAGER)

var user_name: String
var scenario: String
var win_percentage: float
var pin: String

var scenarios: Array

func _ready():
	add_scenario_options()
	create_lobby_canvas.visible = false

func add_scenario_options():
	var scenario_files = files_manager.list_files_in_directory("res://configs/scenarios/")
	scenarios = files_manager.get_json_array_from_files("res://configs/scenarios/", scenario_files)

	for scene in scenarios:
		print(scene.result.name)
		scenario_selector.add_item(scene.result.name)

	scenario_selector.select(-1)
	scenario_selector.text = "Select Scenario"

func _on_scenario_selector_item_selected(index:int):
	if(index != -1):
		scenario = scenario_selector.get_item_text(index)
	else:
		print('no scenario selected')

func _on_user_name_text_changed(new_text:String):
	if(new_text.length() != 0):
		user_name = new_text

func _on_host_btn_pressed():
	disable_first_btns()
	create_lobby_canvas.visible = true;

func _on_create_lobby_btn_pressed():
	if(user_name.length() == 0):
		error_message_create.text = "Please enter a name"
	elif(scenario.length() == 0):
		error_message_create.text = "Please select a scenario"
	else:
		web_socket_manager.send_message.create_lobby(user_name, scenario, win_percentage)

func _on_win_percentage_slider_value_changed(value:float):
	win_pct_slider_text.text = str(win_pct_slider.value) + "%"
	win_percentage = value

func _on_join_lobby_btn_pressed():
	if(user_name.length() == 0):
		error_message_join.text = "Please enter a name"
	elif(pin.length() == 0):
		error_message_join.text = "Please enter a pin"
	else:
		web_socket_manager.send_message.join_lobby(user_name, pin)

func disable_first_btns():
	host_btn.visible = false;
	join_btn.visible = false;

func _on_pin_text_changed(new_text:String):
	if(new_text.length() != 0):
		pin = new_text

func _on_join_btn_pressed():
	disable_first_btns()
	join_lobby_canvas.visible = true;
