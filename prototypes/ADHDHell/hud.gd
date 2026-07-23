class_name HUD extends CanvasLayer

@export var dopamine_system: Dopaminesystem
@export var progress_bar: ProgressBar
@export var game_over_screen: ColorRect

func _ready() -> void:
	dopamine_system.level_updated.connect(_on_updated_dopamine)

func _on_updated_dopamine():
	progress_bar.value = dopamine_system.level

func game_over():
	game_over_screen.visible = true
	
