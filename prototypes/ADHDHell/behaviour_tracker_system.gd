extends Node

## KPI System
var _good_behaviour: bool = false

var current: int:
	set(value):
		_good_behaviour = value
	get:
		return _good_behaviour
	
signal bad_behaviour_occured		
