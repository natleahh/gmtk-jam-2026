extends Node2D

var direction: Vector2

func _process(delta: float) -> void:
	global_position = lerp(global_position, get_global_mouse_position(), 0.05)
	var viewportRect: Rect2 = get_viewport_rect()
	global_position = global_position.clamp(viewportRect.position, viewportRect.position + viewportRect.size)
