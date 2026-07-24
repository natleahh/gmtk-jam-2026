extends Control

const CLAUDE_TEXT: Array[Array] = [
	["Curabitur tincidunt ipsum quis nisi pellentesque, non varius justo convallis.",
	"Aliquam sodales nulla quis felis varius egestas."],
	["Praesent porttitor neque a libero viverra congue.",
	"Maecenas feugiat nibh ac nulla tempor, in efficitur tellus commodo."],
	["Aenean sollicitudin diam sed dui consectetur sagittis sed non nulla.",
	"Vivamus quis ligula fermentum, auctor ante dignissim, semper urna."],
	["Nam laoreet orci et blandit rhoncus.",
	"Sed ut mi id ex aliquet lobortis nec interdum velit."],
	["Ut laoreet erat sit amet lorem feugiat rutrum.",
	"Ut non ipsum id orci dignissim egestas id quis justo."],
	["Mauris vitae nisl imperdiet, lobortis tellus vitae, euismod neque.",
	"Etiam ultricies odio quis dui ornare convallis."],
	["Quisque vel dolor eu nisi sodales semper quis vitae sem.",
	"Etiam id eros sed magna commodo tristique in sit amet magna."],
	["Pellentesque ut velit et urna ultrices aliquet.",
	"Aliquam gravida felis elementum, porta enim vitae, varius lorem."],
	["Integer at massa faucibus nunc vulputate consequat at id ipsum.",
	"Curabitur eleifend ante ut blandit dapibus."]
]

@export_range(0.0, 1.0, 0.01) var initial_success_chance: float = 0.1
@export_range(1.0, 2.0, 0.1) var success_scaling: float = 1.1

@onready var current_text: Array = CLAUDE_TEXT.pick_random()
@export var text_box: ReactiveTextEdit
@export var chat_area: VBoxContainer

var _success_chance: float = initial_success_chance

func _ready() -> void:
	start()
	text_box.submission_pass.connect(_on_correct_input)

func start() -> void:
	text_box.hint = "Claude, please generate the big presentation"
	_success_chance = initial_success_chance

func _on_correct_input(player_input: String) -> void:
	var claude_text: String
	if randf() < _success_chance:
		text_box.hint = ""
		claude_text = "Ok, got it! Generating big presentation."
		start()
	else:
		_success_chance *= success_scaling
		current_text = CLAUDE_TEXT.pick_random()
		text_box.hint = current_text[0]
		claude_text = current_text[1]
	update_chat(player_input, claude_text)

func update_chat(player_input: String, claude_text: String) -> void:
	var player: Label = Label.new()
	player.text = player_input
	var claude: Label = Label.new()
	claude.text = claude_text
	claude.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	chat_area.add_child(player)
	chat_area.add_child(claude)
