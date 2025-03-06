extends Control

@onready var play: Button = $CanvasLayer/Play

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play.connect("pressed", _on_play_pressed)
	
func _on_play_pressed():
	LevelManager.reload_current_level()
