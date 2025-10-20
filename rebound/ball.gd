extends CharacterBody2D

signal left_scored
signal right_scored

@export var initial_speed: float = 500.0
@export var speed_increase: float = 50.0
@export var max_bounce_angle: float = 45.0

var speed: float = 500.0

@onready var top_wall = $"../TopWall"
@onready var bottom_wall = $"../BottomWall"

# Sound effects
@onready var paddle_hit_sound = $"../PaddleHitSound"
@onready var wall_bounce_sound = $"../WallBounceSound"
@onready var score_sound = $"../ScoreSound"

func _ready():
	reset_ball()

func reset_ball():
	position = get_viewport_rect().size / 2
	speed = initial_speed
	
	var random_angle = randf_range(-PI/4, PI/4)
	var direction = Vector2(cos(random_angle), sin(random_angle))
	if randf() > 0.5:
		direction.x *= -1
	
	velocity = direction.normalized() * speed

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		
		if collider.name == "LeftPaddle" or collider.name == "RightPaddle":
			var paddle_center = collider.position.y
			var ball_position = position.y
			var distance_from_center = ball_position - paddle_center
			var normalized_distance = clamp(distance_from_center / 75.0, -1.0, 1.0)
			var bounce_angle = normalized_distance * deg_to_rad(max_bounce_angle)
			var direction_x = 1 if collider.name == "LeftPaddle" else -1
			var new_direction = Vector2(direction_x, tan(bounce_angle))
			
			velocity = new_direction.normalized() * speed
			speed += speed_increase

			# Play paddle hit sound
			if paddle_hit_sound:
				paddle_hit_sound.play()
		
		elif collider.name == "TopWall" or collider.name == "BottomWall":
			velocity = velocity.bounce(collision.get_normal())

			# Play wall bounce sound
			if wall_bounce_sound:
				wall_bounce_sound.play()
	
	if position.x < 0:
		print("Ball went off left side - Right scores!")
		right_scored.emit()
		reset_ball()

		# Play score sound
		if score_sound:
			score_sound.play()
		
	elif position.x > get_viewport_rect().size.x:
		print("Ball went off right side - Left scores!")
		left_scored.emit()
		reset_ball()

		# Play score sound
		if score_sound:
			score_sound.play()
