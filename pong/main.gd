extends Node2D

# Score variables
var left_score: int = 0
var right_score: int = 0

# References to UI elements
@onready var left_score_label = $UI/LeftScore
@onready var right_score_label = $UI/RightScore
@onready var ball = $Ball
@onready var game_over_panel = $UI/GameOverPanel
@onready var game_over_text = $UI/GameOverPanel/VBoxContainer/GameOverText
@onready var restart_button = $UI/GameOverPanel/VBoxContainer/RestartButton
@onready var menu_button = $UI/GameOverPanel/VBoxContainer/MenuButton
@onready var right_paddle = $RightPaddle

func _ready():
	print("Main script ready")
	print("Ball reference: ", ball)
	print("Left score label: ", left_score_label)
	print("Right score label: ", right_score_label)
	print("Game over panel: ", game_over_panel)
	print("Restart button: ", restart_button)
	print("Menu button: ", menu_button)
	
	# Set AI based on game mode
	if right_paddle:
		if GameManager.is_single_player():
			right_paddle.is_ai = true
			right_paddle.setup_ai()  # Make sure ball reference is set
			print("Single player mode - AI enabled")
		else:
			right_paddle.is_ai = false
			print("Two player mode - AI disabled")
	
	# Hide game over screen initially
	if game_over_panel:
		game_over_panel.visible = false
		print("Game over panel hidden")
	else:
		print("ERROR: Game over panel not found!")
	
	# Connect restart button
	if restart_button:
		restart_button.pressed.connect(_on_restart_pressed)
		print("Restart button connected")
	else:
		print("ERROR: Restart button not found!")
	
	# Connect menu button
	if menu_button:
		menu_button.pressed.connect(_on_menu_pressed)
		print("Menu button connected")
	else:
		print("ERROR: Menu button not found!")
	
	# Connect to ball's scoring signal
	if ball:
		ball.left_scored.connect(_on_left_scored)
		ball.right_scored.connect(_on_right_scored)
		print("Signals connected successfully")
	else:
		print("ERROR: Ball not found!")
	
	update_score_display()

func _on_left_scored():
	print("Left player scored!")
	left_score += 1
	update_score_display()
	check_game_over()

func _on_right_scored():
	print("Right player scored!")
	right_score += 1
	update_score_display()
	check_game_over()

func update_score_display():
	left_score_label.text = str(left_score)
	right_score_label.text = str(right_score)

func check_game_over():
	# Game ends when someone reaches 5 points (adjust as needed)
	if left_score >= 5:
		show_game_over("Left Player Wins!")
	elif right_score >= 5:
		show_game_over("Right Player Wins!")

func show_game_over(winner_text: String):
	game_over_text.text = winner_text
	game_over_panel.visible = true
	get_tree().paused = true
	print("Game over shown: ", winner_text)

func _on_restart_pressed():
	print("Restart button pressed")
	# Reset scores
	left_score = 0
	right_score = 0
	update_score_display()
	
	# Hide game over screen
	game_over_panel.visible = false
	
	# Unpause and restart
	get_tree().paused = false
	
	# Reset ball
	if ball:
		ball.reset_ball()

func _on_menu_pressed():
	print("Menu button pressed")
	# Unpause before changing scene
	get_tree().paused = false
	# Return to main menu
	get_tree().change_scene_to_file("res://main_menu.tscn")
