extends Control

const CLAUDE_TEXT: Array[Array] = [
	["doo", "bar"],
	["baz", "quxx"],
]

@onready var current_text: Array = CLAUDE_TEXT.pick_random()

@export var text_box: ReactiveTextEdit
@export var chat_window: Control

func _ready() -> void:
	text_box.submission_pass.connect(_on_correct_input)

func start() -> void:
	text_box.hint = "Claude, please genereate the big presentation"

func _on_correct_input(player_input: String):
	var claude_text: String
	if randf() > 0.5:
		text_box.hint = ""
		claude_text = "Ok, got it! Generating big presentation."
	else:
		current_text = CLAUDE_TEXT.pick_random()
		text_box.hint = current_text[0]
		claude_text = current_text[1]
	chat_window.update_chat(input_text, claude_text)
	
	
