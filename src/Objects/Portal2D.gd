tool
extends Area2D

export var next_scene: PackedScene;
#$AnimationPlayer == get_node("AnimationPlayer") 
onready var anim_player: AnimationPlayer = $AnimationPlayer;
func _get_configuration_warning() -> String:
	return "next_scene cant be empty" if not next_scene else "";

func teleport() -> void:
	anim_player.play("fade_in");
	#wait for anim_player to send "animation_fisnihed" signal
	yield(anim_player,"animation_finished");
	get_tree().change_scene_to(next_scene);


func _on_body_entered(_body: PhysicsBody2D) -> void:
	teleport();
