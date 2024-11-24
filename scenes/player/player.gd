extends CharacterBody2D

@export var speed  =300
var can_pick = true

var health = 100:
	set(value):
		health = value
		$CanvasLayer/Control/TextureProgressBar.value = value
		if health <= 0:
			get_tree().change_scene_to_file("res://scenes/menu/game_over.tscn")
@onready var sprite: Sprite2D = $Sprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	var dir =  Input.get_vector("left","right","up","down")
	velocity = dir *speed
	move_and_slide()
	#print(point_collected)
	if velocity ==Vector2.ZERO:
		animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.play("run")
	if velocity.x <0:
		animated_sprite_2d.flip_h = true
	elif velocity.x >0:
		animated_sprite_2d.flip_h = false

func _on_timer_timeout() -> void:
	health -=5


func _on_hurt_body_entered(body: Node2D) -> void:
	health -=15

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://scenes/menu/pause.tscn")
		#get_tree().paused = true
