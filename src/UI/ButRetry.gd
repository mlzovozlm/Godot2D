extends Button

export(String, FILE) var retry_scene := "";

func _on_button_up() -> void:
	PlayerData.score = 0;
	get_tree().paused = false;
	get_tree().change_scene(retry_scene);
