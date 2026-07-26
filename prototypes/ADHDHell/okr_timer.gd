extends Timer


func _ready() -> void:
	OkrSystem.completion_update.connect(_on_okr_system_completion_update)
	
func _on_okr_system_completion_update() -> void:
	start()
