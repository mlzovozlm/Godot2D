extends Actor

export var score := 10;

func _ready() -> void:
	#prevent processing when off-screen
	set_physics_process(false);
	_velocity.x = -speed.x;
	
func _physics_process(delta) -> void:
	_velocity.y += gravity * delta;
	if is_on_wall():
		_velocity.x *= -1.0;
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y;


func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return;
	die();

func die() -> void:
	$CollisionShape2D.set_deferred("disabled", true);
	PlayerData.score += score;
	queue_free();