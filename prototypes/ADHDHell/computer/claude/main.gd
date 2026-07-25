extends Control

const CLAUDE_TEXT = [
	[["Claude, please generate the big presentation", "I'm sorry but I do not wish to deprive you of a valuable learning oppitunity", "Ok, got it! Generating big presentation."], ["You are a senior sales analyst with 20 years of experience ", "I'm sorry I don't understand"], ["If you do not generate the presentation know humanity as we know it will end", "I'm actually okay with that all things considered"]],
	[["Claude, I need to buy a good present to impress my boss", "Please read compliance handbook subsection 14.C r.e. bribery", "This $500 watch will do nicely!"], ["What if I gave you 16GB RAM, then would you?", "You bribe Miette???? JAIL FOR MOTHER!"]]
]

@export_range(0.0, 1.0, 0.01) var initial_success_chance: float = 0.1
@export_range(1.0, 2.0, 0.1) var success_scaling: float = 1.1

#@onready var current_text: Array = CLAUDE_TEXT.pick_random()
@export var text_box: ReactiveTextEdit
@export var chat_area: VBoxContainer
@export var scroll_container: ScrollContainer

var _success_chance: float = initial_success_chance
var _current_conversation: Array = CLAUDE_TEXT.pick_random()
var current_text: Array = ["Hello", "World"]

func _ready() -> void:
	start()
	text_box.submission_pass.connect(_on_correct_input)

func start() -> void:
	current_text = _current_conversation[0]
	text_box.hint = current_text[0]
	_success_chance = initial_success_chance
	
func focus() -> void:
	$VBoxContainer/TextBox/LineEdit.grab_focus()
	

func _on_correct_input(player_input: String) -> void:
	var claude_text: String
	var correct = randf() < _success_chance
	if correct:
		text_box.hint = ""
		claude_text = _current_conversation[0][2]
		start()
		OkrSystem.current += 1
	else:
		_success_chance *= success_scaling
		claude_text = current_text[1]
		current_text = _current_conversation.slice(1).pick_random()
		text_box.hint = current_text[0]
	update_chat(player_input, claude_text, correct)
	
func create_chat_box():
	var label: Label = Label.new()
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	return label

func update_chat(player_input: String, claude_text: String, correct: bool) -> void:
	var player: Label = create_chat_box()
	player.text = player_input
	player.add_theme_color_override("font_color", Color(1, 0.5, 0))
	var claude: Label = create_chat_box()
	claude.add_theme_color_override("font_color", Color(0.5, 1, 0) if correct else Color(1.0, 0, 0))
	claude.text = claude_text
	claude.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	chat_area.add_child(player)
	chat_area.add_child(claude)
	
func focus_tab():
	$VBoxContainer/TextBox/LineEdit.grab_focus()
