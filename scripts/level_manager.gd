extends Node

var levels = [
	preload("res://scenes/level_1.tscn"),
	preload("res://scenes/level_2.tscn")
]

var is_loading = false
var current_level = 0
@onready var game = get_tree().root.get_child(0)

func _ready():
	print("LevelManager Ready")  # Debugging Line
	instantiate_level(0)
 # Ensures the first level is loaded only once

func instantiate_level(level_index):
	if level_index < 0 or level_index >= levels.size():
		print("Invalid level index:", level_index)
		return
	
	if is_loading:
		print("Already loading a level, skipping request.")
		return
	
	print("Instantiating Level:", level_index)
	is_loading = true
	
	# Remove previous level if exists
	if game.get_child_count() > 0:
		var previous_level = game.get_child(game.get_child_count() - 1)
		game.remove_child(previous_level)
		previous_level.queue_free()
		await get_tree().process_frame  # Ensure it's fully removed
	
	# Instantiate and add the new level
	var level_instance = levels[level_index].instantiate()
	game.add_child(level_instance)

	print("Level Loaded:", level_index)
	current_level += 1
	is_loading = false
	
func next_level():
	if is_loading:
		print("Game is still loading, skipping level change.")
		return

	if current_level >= levels.size():
		print("Game finished")
		return

	instantiate_level(current_level)
