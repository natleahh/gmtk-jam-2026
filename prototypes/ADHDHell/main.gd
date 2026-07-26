extends Node2D

@export var dopamine_system: Dopaminesystem
@export var hud: HUD
@export var clock: Sprite2D
@export var okr_timer: Timer
@export var deadline_alert: Label

func _ready() -> void:
	dopamine_system.level_depleted.connect(game_over)
	
func _process(delta: float) -> void:
	clock.update_clock(okr_timer.time_left, okr_timer.wait_time)

func game_over():
	var game_over_text: String
	if dopamine_system.level <= 0:
		game_over_text = "NO MORE DOPAMINE, SORRY! :("
	else:
		game_over_text = "GAME OVER: OH NO, WE MISSED THE EOQ (End of Quarter) DEALINE :("
	hud.game_over(game_over_text, dopamine_system.level > 0)
	process_mode = Node.PROCESS_MODE_DISABLED
	
	
