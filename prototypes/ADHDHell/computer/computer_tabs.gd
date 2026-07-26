extends TabContainer

@export var clyde: Control

func set_tab_focus(tab: int):
	if(tab == 0):
		clyde.focus()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_tab_focus(0) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tab_changed(tab: int) -> void:
	set_tab_focus(tab) # Replace with function body
	BehaviourTrackerSystem._good_behaviour = tab == 0
