extends Node

@onready var game = get_tree().root.get_child(0)
@onready var level_manager = get_tree().root.get_node("LevelManager")

func _ready():
	# No need to load the first level here, let LevelManager handle it.
	pass
