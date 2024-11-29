extends RigidBody2D 

@export var throw_vel = 1000
@onready var cam = get_tree().get_first_node_in_group("cam")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var object: RigidBody2D =$"."



@onready var throw_mark = get_tree().get_first_node_in_group("pick-marker")
var picked = false
var gravity =10

func _physics_process(delta: float) -> void:
	if picked == true:
		self.position = get_tree().get_first_node_in_group("pick-marker").global_position

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pick"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if player and player.can_pick == true:
				picked = true
				player.can_pick = false
				#player.speed -= 200

	if Input.is_action_just_pressed("throw") and picked == true:
		picked = false
		player.can_pick = false
		object.transform = throw_mark.global_transform
		object.linear_velocity= object.transform.x * throw_vel
		object.gravity = gravity
		#player.speed = 200



func _on_area_2d_body_entered(body: Node2D) -> void:
	player.can_pick = true


func _on_hit_box_body_entered(body: Node2D) -> void:
	player.health +=2
	cam.shake(1,1)
	body.queue_free()
