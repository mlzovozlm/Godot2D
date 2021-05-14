extends Control

onready var LblScore: Label = $LblScore;

func _ready() -> void:
	LblScore.text = LblScore.text % [PlayerData.score, PlayerData.death]; 
