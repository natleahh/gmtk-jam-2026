class_name OKRSystem extends Node

@export var okr_timer: Timer
## KPI System
@export_range(0, 20) var max: int = 3
@export var real_current: int = 0

var current: int:
	set(value):
		completion_update.emit()
		real_current += 1
	get:
		return real_current 
		
signal completion_update

func reset():
	real_current = 0
