class_name Dopaminesystem extends Node

@export_range(0, 1, 0.01) var dopamine_decay: float
var level: float = 100

signal level_updated
signal level_depleted

func update_level(change: float) -> void:
	level += change
	level_updated.emit()
	

func _process(delta: float) -> void:
	update_level(-dopamine_decay)
	
	if level < 0:
		level_depleted.emit()
