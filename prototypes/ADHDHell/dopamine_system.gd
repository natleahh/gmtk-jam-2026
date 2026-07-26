class_name Dopaminesystem extends Node

@export_range(0, 1, 0.01) var dopamine_decay: float
@export var dopamine_healing: float = 0.2
var level: float = 100

@export var bad_behaviour_penalty: float = 20

signal level_updated
signal level_depleted

func update_level(change: float) -> void:
	level += change
	level = clamp(level, -1, 100)
	level_updated.emit()	
	
func _ready() -> void:
	BehaviourTrackerSystem.bad_behaviour_occured.connect(caught_behaving_badly)	
	

func _process(delta: float) -> void:
	if BehaviourTrackerSystem._good_behaviour:
		update_level(-dopamine_decay)
	else:
		update_level(dopamine_healing)
	
	if level < 0:
		level_depleted.emit()


func caught_behaving_badly() -> void:
	update_level(-bad_behaviour_penalty)
	
