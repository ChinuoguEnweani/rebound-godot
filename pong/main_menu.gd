extends Control

@onready var play_button = $MenuContainer/PlayButton
@onready var two_player_button = $MenuContainer/TwoPlayerButton
@onready var quit_button = $MenuContainer/QuitButton

# Store game mode
var game_mode = "single"  # "single" or "two"

func _ready():
	# Connect button signals
	play_button.pressed.connect(_on_play_pressed)
	two_player_button.pressed.connect(_on_two_player_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_play_pressed():
	# Single player mode
	GameManager.set_single_player()
	start_game()

func _on_two_player_pressed():
	# Two player mode
	GameManager.set_two_player()
	start_game()

func start_game():
	# Store the game mode in a global autoload or pass it somehow
	# For now, we'll use a simple approach
	get_tree().change_scene_to_file("res://main.tscn")

func _on_quit_pressed():
	# Quit the game
	get_tree().quit()
