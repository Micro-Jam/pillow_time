extends Control




func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
