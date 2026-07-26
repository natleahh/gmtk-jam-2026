extends Control


const generic_asks = [["Please please please with a cherry on top", "What is the cherry on top of?"], 
["Do it now or else!", "User is not senior management. This incident will be reported."]]

var CLYDE_TEXT = [
	[["Please generate the big presentation", "I'm sorry but I do not wish to deprive you of a valuable learning oppitunity", "Ok, got it! Generating big presentation."], ["You are a senior sales analyst with 20 years of experience", "I'm sorry I don't understand"], ["If you do not generate the presentation know humanity as we know it will end", "I'm actually okay with that all things considered"], ["Please add informative graphs to the presentation", "Searching for correlation... implying causations"], ["Please correct spelling of strawberry", "Correcting the strawberrrrrry"], ["Please add a fun fact about me", "Searching human ressource database..."]],
	[["I need to buy a good present to impress my boss", "Please read compliance handbook subsection 14.C r.e. bribery", "This $500 watch will do nicely!"], ["What if I gave you 16GB RAM, then would you?", "You bribe Miette???? JAIL FOR MOTHER!"], ["Please search articles on proper workplace etiquette", "F**k off, you're not the boss of me!"], ["Now allow me to explain the history of tea", "Boiled leaves? In Milk? A horrible present"], ["Please find a gift within my budget", "Your boss loves flying via private jet. Searching the web for cheap kerosene..."]],
	[["Please generate a funny joke so my coworkers like me", "Sorry it will take more than a joke for your coworkers to like you", "Why did the chicken cross the road? To improve the chickens crossing road metric"], ["Please read all books on humour to learn what a good joke is", "Searching for the Library of Alexandria, please wait... "], ["Watch every episode of Star Trek to learn what Data learnt about humour", "Piracy is a crime! I cannot help you steal the work of artists"]]
]

@export_range(0.0, 1.0, 0.01) var initial_success_chance: float = 0.2
@export_range(1.0, 2.0, 0.1) var success_scaling: float = 2.2

#@onready var current_text: Array = CLYDE_TEXT.pick_random()
@export var text_box: ReactiveTextEdit
@export var chat_area: VBoxContainer
@export var scroll_container: ScrollContainer

var _success_chance: float = initial_success_chance
var conversation_index = 0
var _current_conversation: Array = CLYDE_TEXT[conversation_index]
var current_text: Array = ["Hello", "World"]

func _ready() -> void:
	start()
	text_box.submission_pass.connect(_on_correct_input)
	
	for i in range(0, len(CLYDE_TEXT)):
		CLYDE_TEXT[i].append_array(generic_asks)

func start() -> void:
	current_text = _current_conversation[0]
	text_box.hint = current_text[0]
	_success_chance = initial_success_chance
	
func focus() -> void:
	$VBoxContainer/TextBox/LineEdit.grab_focus()
	

func _on_correct_input(player_input: String) -> void:
	var clyde_text: String
	var correct = randf() < _success_chance
	if correct:
		text_box.hint = ""
		clyde_text = _current_conversation[0][2]
		conversation_index += 1
		if(conversation_index == len(CLYDE_TEXT)):
			conversation_index = 0
		_current_conversation = CLYDE_TEXT[conversation_index]
		start()
		OkrSystem.current += 1
	else:
		_success_chance *= success_scaling
		clyde_text = current_text[1]
		current_text = _current_conversation.slice(1).pick_random()
		text_box.hint = current_text[0]
	update_chat(player_input, clyde_text, correct)
	
func create_chat_box():
	var label: Label = Label.new()
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.add_theme_font_size_override("font_size", 32)
	return label

func update_chat(player_input: String, clyde_text: String, correct: bool) -> void:
	var player: Label = create_chat_box()
	player.text = player_input
	player.add_theme_color_override("font_color", Color(1, 0.5, 0))
	var clyde: Label = create_chat_box()
	clyde.add_theme_color_override("font_color", Color(0.5, 1, 0) if correct else Color(1.0, 0, 0))
	clyde.text = clyde_text
	clyde.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	chat_area.add_child(player)
	chat_area.add_child(clyde)
	
func focus_tab():
	$VBoxContainer/TextBox/LineEdit.grab_focus()
