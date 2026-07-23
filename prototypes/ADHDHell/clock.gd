extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var point = Vector2(0, 0)
	

func update_clock(time_remaining: float, total_time: float):
	var complete_ratio = time_remaining / total_time
	$Clockhand.rotation = (PI * 2) * complete_ratio
