extends Node2D

@export_range(-1, 1, 0.1) var initial_velocity: float

@export var patrol_follow: PathFollow2D
@export var boss_patrolling_sprite: AnimatedSprite2D
@export var patrol_timer: Timer
@export var sus_timer: Timer
@export var check_complete_timer: Timer

var velocity: float
var current_state = BossState.PATROL

enum BossState {PATROL, SUS, CHECKING, PISSED, SATISFIED}

func _ready() -> void:
	velocity = initial_velocity
	current_state = BossState.PATROL
	set_random_wait_time()
	

func _process(delta: float) -> void:
	match current_state:
		BossState.PATROL:
			switch_animation("patrol")
			# Progressing Logic
			var next_position: float = patrol_follow.progress_ratio + velocity
			if next_position < 0 or next_position > 1:
				velocity *= -1
				
			patrol_follow.progress_ratio += velocity * delta
			
			# Sprite Logic
			boss_patrolling_sprite.flip_h = velocity > 0
		BossState.CHECKING:
			if BehaviourTrackerSystem._good_behaviour:				
				current_state = BossState.SATISFIED
				switch_animation("satisfied")
				$SatisfiedSound.play()

			else:
				current_state = BossState.PISSED
				BehaviourTrackerSystem.bad_behaviour_occured.emit()
				switch_animation("pissed")
				$PissedSound.play()


func _on_timer_timeout() -> void:
	print("Setting sus")
	current_state = BossState.SUS
	switch_animation("sus")
	velocity = 0
	sus_timer.start()

func set_random_wait_time() -> void:
	patrol_timer.start(randfn(5, 2) + 0.5)

func switch_animation(animation_name: String) -> void:
	if boss_patrolling_sprite.animation != animation_name:
		boss_patrolling_sprite.play(animation_name)


func _on_sus_timer_timeout() -> void:
	current_state = BossState.CHECKING
	check_complete_timer.start()
	$SusSound.play()

func _on_check_complete_timer_timeout() -> void:
	current_state = BossState.PATROL
	velocity = initial_velocity * (1 if randi_range(0, 1) == 1 else -1)
	set_random_wait_time()
