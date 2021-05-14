extends Actor

export var stomp_impulse := 300.0;

func _physics_process(_delta) -> void:
	#get direction
	var direction := get_direction();
	#interrupted jump == jump lower
	var is_jump_interrupted := Input.is_action_just_released("jump") and _velocity.y < 0.0;
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted);
	#with move_and_slice, there's still need for multiplying factors like gravity with delta
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL);

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	);

func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool
	) -> Vector2:
	var new_velocity := linear_velocity;
	new_velocity.x = direction.x * speed.x;
	
	new_velocity.y += gravity * get_physics_process_delta_time();
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y;
	if is_jump_interrupted:
		new_velocity.y = 0.0; 
	return new_velocity;


func _on_EnemyDetector_area_entered(_area) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse);

func calculate_stomp_velocity(
	linear_velocity: Vector2,
	impulse: float
) -> Vector2:
	var out := linear_velocity;
	out.y = -impulse;
	return out;
	
func _on_EnemyDetector_body_entered(_body) -> void:
	die();

func die() -> void:
	PlayerData.death += 1;
	queue_free();
