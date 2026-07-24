class_name ReactiveTextEdit extends Control

var hint: String = "Lorem Ipsum"

signal submission_pass(string: String)

func _ready() -> void:
	$LineEdit.text_changed.connect(_on_input_text_change)
	$LineEdit.text_submitted.connect(_on_input_submitted)

func _on_input_text_change(input_text: String) -> void:
	var player_text = ""
	var remaining_text = "[color=%s]" % Color("dark gray").to_html() + hint.right(-len(input_text))
	
	if input_text == "":
		remaining_text += hint
	if hint == input_text:
		player_text = "[color=%s]" % Color("green").to_html() + input_text
	elif hint.begins_with(input_text):
		player_text = input_text
	else:
		for i in min(len(hint), len(input_text)):
			if input_text[i] == hint[i]:
				player_text += input_text[i]
			else: 
				player_text += (
					"[color={0}]{1}[/color]".format([Color("red").to_html(), input_text[i]])
					)
		if len(input_text) > len(hint):
			player_text += "[color={0}]{1}[/color]".format([Color("red").to_html(), input_text.right(-len(hint))])
	$RichTextLabel.text = player_text + remaining_text

func _on_input_submitted(input_text: String) -> void:
	if hint == input_text:
		submission_pass.emit(input_text)
		$LineEdit.clear()
