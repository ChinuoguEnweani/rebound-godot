extends CharacterBody2D

@export var speed: float = 600.0
@export var up_action: String = "move_up"
@export var down_action: String = "move_down"
@export var is_ai: bool = false  # Enable AI control
@export var ai_reaction_speed: float = 0.5  # How fast AI reacts (0-1, lower is harder)
@export var ai_prediction_error: float = 20.0  # How much AI can miss (in pixels)
@export var ai_smoothness: float = 5.0  # How smoothly AI moves (higher = smoother)

# These will automatically reference the walls in the Main scene
@onready var top_wall = $"../TopWall"
@onready var bottom_wall = $"../BottomWall"

const PADDLE_HEIGHT := 150.0  # Match your paddle sprite height

# AI variables
var ball_reference: Node2D = null
var ai_target_y: float = 0.0

func _ready():
	# Find the ball for AI tracking
	if is_ai:
		setup_ai()

func setup_ai():
	ball_reference = get_node_or_null("../Ball")
	if ball_reference:
		print(name, " AI setup complete - ball found")
	else:
		print(name, " AI setup failed - ball not found")

func _process(delta: float) -> void:
	var velocity_input = 0.0
	
	if is_ai:
		# Make sure ball reference is set
		if not ball_reference:
			setup_ai()
		
		# AI Control
		if ball_reference:
			velocity_input = get_ai_input()
	else:
		# Human Control
		if Input.is_action_pressed(up_action):
			velocity_input = -1
		if Input.is_action_pressed(down_action):
			velocity_input += 1
	
	# Move paddle
	position.y += velocity_input * speed * delta
	
	# Calculate dynamic boundaries based on wall positions
	# Need to account for wall thickness/height
	var top_wall_bottom = top_wall.position.y + 90.0  # Adjust 60 to match your wall height
	var bottom_wall_top = bottom_wall.position.y - 90.0  # Bottom wall position is already at its top
	
	var min_y = top_wall_bottom + PADDLE_HEIGHT / 2
	var max_y = bottom_wall_top - PADDLE_HEIGHT / 2
	
	# Keep paddle within bounds
	position.y = clamp(position.y, min_y, max_y)

func get_ai_input() -> float:
	if not ball_reference:
		return 0.0
	
	# Only track ball if it's moving toward this paddle
	var ball_velocity = ball_reference.velocity if "velocity" in ball_reference else Vector2.ZERO
	
	# Check if ball is moving toward AI paddle (adjust based on which side)
	var is_ball_approaching = false
	if name == "RightPaddle" and ball_velocity.x > 0:
		is_ball_approaching = true
	elif name == "LeftPaddle" and ball_velocity.x < 0:
		is_ball_approaching = true
	
	# Calculate target position
	if is_ball_approaching:
		# Add some prediction error to make AI beatable
		var error = randf_range(-ai_prediction_error, ai_prediction_error)
		ai_target_y = ball_reference.position.y + error
	else:
		# Return to center when ball is not approaching
		ai_target_y = (top_wall.position.y + bottom_wall.position.y) / 2
	
	# Calculate distance to target
	var distance_to_target = ai_target_y - position.y
	
	# Add reaction delay based on ai_reaction_speed
	var dead_zone = 10.0 + (ai_reaction_speed * 50.0)  # Larger dead zone for slower AI
	
	if abs(distance_to_target) < dead_zone:
		return 0.0
	elif distance_to_target > 0:
		return 1.0  # Move down
	else:
		return -1.0  # Move up
