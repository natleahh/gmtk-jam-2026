extends Node2D

@export_range(-1, 1, 0.1) var initial_velocity: float

@export var patrol_follow: PathFollow2D
@export var boss_patrolling_sprite: AnimatedSprite2D
@export var patrol_timer: Timer

var velocity: float

func _ready() -> void:
	velocity = initial_velocity
	boss_patrolling_sprite.animation = "walk"
	set_random_wait_time()
	
	for i in 100:
		print(randfn(5, 2.0) + 1)

func _process(delta: float) -> void:
	# Progressing Logic
	var next_position: float = patrol_follow.progress_ratio + velocity
	if next_position < 0 or next_position > 1:
		velocity *= -1
		
	patrol_follow.progress_ratio += velocity * delta
	
	# Sprite Logic
	boss_patrolling_sprite.flip_h = velocity > 0

func _on_timer_timeout() -> void:
	print("timer")
	boss_patrolling_sprite.play("glare")
	velocity = 0


func _on_boss_patrolling_sprite_animation_finished() -> void:
	if boss_patrolling_sprite.animation == "glare":
		boss_patrolling_sprite.animation = "walk"
		velocity = initial_velocity * (1 if randi_range(0, 1) == 1 else -1)
		set_random_wait_time()

func set_random_wait_time() -> void:
	patrol_timer.start(randfn(5, 2) + 0.5)
