extends Control

@onready var play: Button = $CanvasLayer/Play
@onready var music: AudioStreamPlayer2D = $Music

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play.connect("pressed", _on_play_pressed)
	
	
func _on_play_pressed():
	print("Starting Game...")
	LevelManager.current_level = 0  # Ensure level starts from the first level
	LevelManager.reload_current_level()
	
