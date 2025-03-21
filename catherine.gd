extends CharacterBody2D

@onready var navigation_agent = $CatherineAgent2D
@onready var anim = $CatherineSprite2D

@export var speed = 30  
@export var random_rest_interval = 3

var targets = [
	Vector2(8 * 8, -29 * 8), Vector2(33 * 8, -7 * 8), 
	Vector2(47 * 8, -19 * 8), Vector2(76 * 8, -14 * 8), 
	Vector2(87 * 8, -34 * 8), Vector2(90 * 8, -23 * 8), 
	Vector2(91 * 8, -58 * 8), Vector2(66 * 8, -58 * 8), 
	Vector2(16 * 8, -57 * 8), Vector2(8 * 8, -50 * 8), 
	Vector2(36 * 8, -56 * 8), Vector2(51 * 8, -37 * 8), 
	Vector2(58 * 8, -39 * 8), Vector2(46 * 8, -21 * 8), 
	Vector2(67 * 8, -14 * 8), Vector2(20 * 8, -20 * 8), 
]
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
