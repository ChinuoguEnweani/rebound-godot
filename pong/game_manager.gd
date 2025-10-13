extends Node

# Game mode: "single" or "two"
var game_mode: String = "single"

func set_single_player():
	game_mode = "single"

func set_two_player():
	game_mode = "two"

func is_single_player() -> bool:
	return game_mode == "single"

func is_two_player() -> bool:
	return game_mode == "two"
