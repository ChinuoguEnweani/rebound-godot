extends Node2D

@export var speed: float = 600.0  # Paddle speed
@export var up_action: String = "p1_up"
@export var down_action: String = "p1_down"

# These will automatically reference the walls in the Main scene
@onready var top_wall = $"TopWall"
@onready var bottom_wall = $"BottomWall"

const PADDLE_HEIGHT := 150.0  # Match your paddle sprite height

func _process(delta: float) -> void:
	var velocity = 0.0

	# Get input from assigned actions
	if Input.is_action_pressed(up_action):
		velocity -= 1
	if Input.is_action_pressed(down_action):
		velocity += 1

	# Move paddle
	position.y += velocity * speed * delta

	# Calculate dynamic boundaries based on wall positions
	var min_y = top_wall.position.y + PADDLE_HEIGHT / 2
	var max_y = bottom_wall.position.y - PADDLE_HEIGHT / 2

	# Keep paddle within bounds
	position.y = clamp(position.y, min_y, max_y)
