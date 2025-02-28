extends Node




var levels = [
	"res://scenes/level_1.tscn",
	"res://scenes/level_2.tscn"
]

var current_level = 0
var current_scene = null
@onready var game_node = get_node("/root/Game")  # Ensure we reference the Game node

func _ready():
	await get_tree().process_frame  # Wait a frame to ensure Game scene is ready
	load_level()

func load_level():
	call_deferred("_deferred_load_level")  # Call deferred function

func _deferred_load_level():
	if current_scene:
		current_scene.queue_free()  # Remove old level

	var level = load(levels[current_level]).instantiate()
	game_node.add_child(level)
	current_scene = level  # Store reference to the new level

var level_changing = false  # Prevents multiple calls

func next_level():
	if level_changing:  
		return  # Stop if already transitioning

	level_changing = true  # Mark as transitioning

	print("Current level index:", current_level)
	print("Total levels:", levels.size())

	if current_level < levels.size():
		current_level += 1
		load_level()
	else:
		print("Game completed! No more levels.")
		#get_tree().change_scene_to_file("res://EndScreen.tscn")

	await get_tree().process_frame  # Wait one frame
	level_changing = false  # Reset after transition
