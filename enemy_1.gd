extends CharacterBody2D

var SPEED = 80
var dmg:float
var knockback : Vector2
var health =0
'var health :float= 100:
	set(value):
		health = value
		$health.value = value
		if health <=0.0:
			queue_free()'



@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D



@onready var attack_timer = $Timer
@onready var player =get_tree().get_first_node_in_group("player")

var randomnum

enum {
	SURROUND,
	ATTACK,
	HIT,
}

var state = SURROUND

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()
	

	

func _physics_process(delta):
	match state:
		SURROUND:
			move(get_circle_position(randomnum), delta)
		ATTACK:
			move(player.global_position, delta)
		HIT:
			move(player.global_position, delta)
			knockback = knockback.move_toward(Vector2(10,10),10)
			velocity += knockback
			var collider = move_and_collide(velocity * delta)
			if collider:
				collider.get_collider().knockback = (collider.get_collider().global_position - global_position).normalized() * 50
			print("HIT")
			#Slash ANIM

func move(target, delta):
	var direction = (target - global_position).normalized() 
	var desired_velocity =  direction * SPEED
	var steering = (desired_velocity - velocity) * delta * 10
	velocity += steering
	move_and_slide()
	if direction.x<0:
		animated_sprite.flip_h = true
		animated_sprite.play("run")
	elif direction.x>0:
		animated_sprite.play("run")
		animated_sprite.flip_h = false
func get_circle_position(random):
	var kill_circle_centre = player.global_position
	var radius = 40
	 #Distance from center to circumference of circle
	var angle = random * PI * 2;
	var x = kill_circle_centre.x + cos(angle) * radius;
	var y = kill_circle_centre.y + sin(angle) * radius;

	return Vector2(x, y)


func _on_timer_timeout() -> void:
	state = ATTACK


'func _on_area_2d_area_entered(_area: Area2D) -> void:
	health -=100'
