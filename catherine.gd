extends CharacterBody2D

@onready var navigation_agent = $CatherineAgent2D
@onready var anim = $CatherineSprite2D

@export var speed = 30  
@export var random_rest_interval = 3

var targets = [
	Vector2(6 * 8, -8 * 8),
	Vector2(20 * 8, -10 * 8),
	Vector2(34 * 8, -12 * 8),
	Vector2(48 * 8, -14 * 8),
	Vector2(62 * 8, -16 * 8),
	Vector2(76 * 8, -18 * 8),
	Vector2(90 * 8, -20 * 8),
	Vector2(104 * 8, -22 * 8),
	Vector2(118 * 8, -24 * 8),
	Vector2(100 * 8, -26 * 8),
	Vector2(86 * 8, -28 * 8),
	Vector2(72 * 8, -30 * 8),
	Vector2(58 * 8, -32 * 8),
	Vector2(44 * 8, -12 * 8),
	Vector2(30 * 8, -16 * 8),
	Vector2(16 * 8, -24 * 8),
	Vector2(12 * 8, -30 * 8),
	Vector2(36 * 8, -28 * 8),
	Vector2(54 * 8, -20 * 8),
	Vector2(70 * 8, -10 * 8),
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
