extends Node

var score := 0 setget set_score;
var death := 0 setget set_death; 

signal score_update; 
signal player_die; 

func set_score(value: int) -> void:
	score = value;
	emit_signal("score_update");
	
func set_death(value: int) -> void:
	death = value;
	emit_signal("player_die");

func reset() -> void:
	score = 0;
	death = 0;
