class_name OKRSystem extends Node

## KPI System
@export_range(0, 20) var max: int = 3
var _current: int = 0

var current: int:
	set(value):
		completion_update.emit()
		_current += 1
	get:
		return _current
		
signal completion_update
