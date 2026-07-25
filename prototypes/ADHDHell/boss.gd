extends Node2D

@export_range(-1, 1, 0.1) var initial_velocity: float

@export var patrol_follow: PathFollow2D
@export var boss_patrolling_sprite: AnimatedSprite2D
@export var patrol_timer: Timer

var velocity: float
var current_state = BossState.PATROL

enum BossState {PATROL, SUS, CHECKING, PISSED, SATISFIED}

func _ready() -> void:
	velocity = initial_velocity
	set_random_wait_time()
	
	#for i in 100:
		#print(randfn(5, 2.0) + 1)

func _process(delta: float) -> void:
	match current_state:
		BossState.PATROL:
			boss_patrolling_sprite.animation = "patrol"
			# Progressing Logic
			var next_position: float = patrol_follow.progress_ratio + velocity
			if next_position < 0 or next_position > 1:
				velocity *= -1
				
			patrol_follow.progress_ratio += velocity * delta
			
			# Sprite Logic
			boss_patrolling_sprite.flip_h = velocity > 0
		BossState.SUS:
			velocity = 0
			boss_patrolling_sprite.animation = "sus"
		BossState.CHECKING:
			# TODO: Check if player is behaving
			pass
		BossState.PISSED:
			boss_patrolling_sprite.animation = "pissed"
		BossState.SATISFIED:
			boss_patrolling_sprite.animation = "satisfied"

func _on_timer_timeout() -> void:
	current_state = BossState.SUS

func _on_boss_patrolling_sprite_animation_finished() -> void:
	if boss_patrolling_sprite.animation == "sus":
		current_state = BossState.CHECKING
	if boss_patrolling_sprite.animation == "pissed" || boss_patrolling_sprite.animation == "satisfied":
		current_state = BossState.PATROL
		velocity = initial_velocity * (1 if randi_range(0, 1) == 1 else -1)
		set_random_wait_time()

func set_random_wait_time() -> void:
	patrol_timer.start(randfn(5, 2) + 0.5)
