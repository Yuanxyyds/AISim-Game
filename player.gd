extends CharacterBody2D

@onready var navigation_agent = $NavigationAgent2D
@onready var anim = $AnimatedSprite2D

@export var speed = 30  
@export var random_rest_interval = 3

var targets = [Vector2(60 * 8, -9 * 8), Vector2(75 * 8, -10 * 8), 
			   Vector2(78 * 8, -19 * 8), Vector2(88 * 8, -55 * 8), 
			   Vector2(3 * 8, -54 * 8), Vector2(3 * 8, -23 * 8)]
var current_target = Vector2.ZERO
var is_resting = false
var timer = 0

func _ready():
	choose_new_target()

func _physics_process(delta):
	if is_resting:
		timer -= delta
		if timer <= 0:
			is_resting = false
			choose_new_target()
	else:
		var direction = (navigation_agent.get_next_path_position() - global_position).normalized()
		
		if direction.x > 0:
			anim.flip_h = false  
		elif direction.x < 0:
			anim.flip_h = true  

		velocity = direction * speed
		move_and_slide()

		if global_position.distance_to(current_target) < 5:
			is_resting = true
			anim.stop()
			timer = random_rest_interval 

	if not is_resting and velocity.length() > 0:
		anim.play("walkforward")

func choose_new_target():
	current_target = targets[randi() % targets.size()]
	navigation_agent.set_target_position(current_target)
