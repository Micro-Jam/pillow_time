extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree()

@onready var animation_player: AnimationPlayer = $AnimationPlayer
func _process(delta: float) -> void:
	animation_player.play("gloom")

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_texture_button_2_pressed() -> void:
	get_tree().quit()
