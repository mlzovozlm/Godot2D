extends Control

onready var scene_tree := get_tree();
onready var pause_overlay : ColorRect = $PauseOverlay;
onready var LblScore: Label = $LblScore;
onready var LblTitle: Label = $PauseOverlay/LblTitle;

var paused := false setget set_paused;

func _ready() -> void:
	PlayerData.connect("score_update", self, "update_interface");
	PlayerData.connect("player_die", self, "_PlayerData_player_die");
	update_interface();

func update_interface() -> void:
	LblScore.text = "Score: %s" % PlayerData.score;

func _PlayerData_player_die() -> void:
	self.paused = true;
	LblTitle.text = "You Sucks!";
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused;
	scene_tree.set_input_as_handled();
	
func set_paused(value: bool) -> void:
	paused = value;
	scene_tree.paused = value;
	pause_overlay.visible = value;
