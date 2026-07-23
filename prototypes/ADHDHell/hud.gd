class_name HUD extends CanvasLayer

@export var main: Node2D

@export var okr_system: OKRSystem
@export var dopamine_system: Dopaminesystem

@export var progress_bar: ProgressBar
@export var game_over_screen: ColorRect
@export var h_box_container: HBoxContainer
@export var color_rect_1: ColorRect
@export var color_rect_2: ColorRect
@export var color_rect_3: ColorRect


@onready var tasks: Array[ColorRect] = [
		color_rect_1,
		color_rect_2,
		color_rect_3,
]

func _ready() -> void:
	dopamine_system.level_updated.connect(_on_updated_dopamine)
	okr_system.completion.connect(_on_update_okr)

		
	
func _on_updated_dopamine():
	progress_bar.value = dopamine_system.level

func _on_update_okr():
	tasks[okr_system.current].color = Color("green")
		
func game_over():
	game_over_screen.visible = true
	
