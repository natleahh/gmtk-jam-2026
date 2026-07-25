extends Node2D



@export var dopamine_system: Dopaminesystem
@export var hud: HUD
@export var clock: Sprite2D
@export var okr_timer: Timer


func _ready() -> void:
	dopamine_system.level_depleted.connect(game_over)
	
func _process(delta: float) -> void:
	clock.update_clock(okr_timer.time_left, okr_timer.wait_time)

func game_over():
	process_mode = Node.PROCESS_MODE_DISABLED
	hud.game_over()
	
