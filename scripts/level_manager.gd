extends Node

var levels = [
	preload("res://scenes/level_1.tscn"),
	preload("res://scenes/level_2.tscn")
]

var endscreen = preload("res://scenes/endscreen.tscn")
var main_menu = preload("res://scenes/main_menue.tscn")
const UI_OVERLAY = preload("res://scenes/ui_overlay.tscn")

var is_loading = false
var current_level = 0
var collected_coins = 0
var coin_checkpoint = 0
var deaths = 0
@onready var game = get_tree().root.get_child(0)

func _ready():
	print("LevelManager Ready")  # Debugging Line
	#var main_menue_instance = main_menu.instantiate()
	#game.add_child(main_menue_instance)
	load_main_menue()
 # Ensures the first level is loaded only once

func load_main_menue():
	# Ensure current_level is reset
	current_level = 0  
	deaths = 0
	collected_coins = 0
	coin_checkpoint = 0
	# Remove all children EXCEPT the main menu
	for child in game.get_children():
		if child != main_menu:  # Keep main menu
			game.remove_child(child)
			child.queue_free()
	
		await get_tree().process_frame  # Ensure cleanup happens properly
	
	# Load and add main menu if it's not already there
	var main_menue_instance = main_menu.instantiate()
	game.add_child(main_menue_instance)
	
func load_restart_menu():
	collected_coins = 0
	for child in game.get_children():
		if child != endscreen:
			game.remove_child(child)
			child.queue_free()
		await get_tree().process_frame
		
	var endscreen_instance = endscreen.instantiate()
	
	game.add_child(endscreen_instance)
	
func reload_current_level():
	instantiate_level(current_level)
	
	
func instantiate_level(level_index):
	coin_checkpoint += collected_coins
	collected_coins = 0
	if level_index < 0 or level_index >= levels.size():
		print("Invalid level index:", level_index)
		return
	
	if is_loading:
		print("Already loading a level, skipping request.")
		return
	
	print("Instantiating Level:", level_index)
	is_loading = true
	
	# Remove previous level if exists
	for child in game.get_children():
		if child != levels[level_index]:
			game.remove_child(child)
			child.queue_free()
		await  get_tree().process_frame
	
	# Instantiate and add the new level
	var level_instance = levels[level_index].instantiate()
	game.add_child(level_instance)
	
	var player_instance = level_instance.get_node("./Player") 
	print("Player instance", player_instance) # Adjust the path if needed
	Globals.player = player_instance
	
	var ui_overlay_instance = UI_OVERLAY.instantiate()
	game.add_child(ui_overlay_instance)
	
	  # Set the player reference in the global singleton
	print("Added UI")
	print("Level Loaded:", level_index)
	
	is_loading = false
	
func next_level():
	current_level += 1
	if is_loading:
		print("Game is still loading, skipping level change.")
		return

	if current_level >= levels.size():
		print("Game finished")
		print(current_level)
		current_level -= 1
		coin_checkpoint += collected_coins
		load_restart_menu()
		return
	
	instantiate_level(current_level)
	
