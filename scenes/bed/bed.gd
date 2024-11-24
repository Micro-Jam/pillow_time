extends Node2D



@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _process(delta: float) -> void:
	animation_player.play("gloom")

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.health += 6
