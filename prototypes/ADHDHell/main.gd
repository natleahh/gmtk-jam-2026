extends Node2D



@export var dopamine_system: Dopaminesystem
@export var hud: HUD

func _ready() -> void:
	dopamine_system.level_depleted.connect(game_over)

func game_over():
	process_mode = Node.PROCESS_MODE_DISABLED
	hud.game_over()
