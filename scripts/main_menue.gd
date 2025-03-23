extends Control

@onready var play: Button = $CanvasLayer/Container/Play
@onready var level_selector_button: Button = $CanvasLayer/Container/LevelSelector
@onready var music: AudioStreamPlayer2D = $Music
@onready var level_selector: CanvasLayer = $LevelSelector
@onready var close: Button = $LevelSelector/Close
@onready var level_button_1: TextureButton = $LevelSelector/Level_Button_1
@onready var level_button_2: TextureButton = $LevelSelector/Level_Button_2
@onready var success: Label = $LevelSelector/Success
@onready var load_game: Button = $CanvasLayer/Container/Load
@onready var success_load: Label = $CanvasLayer/Success_load



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play.connect("pressed", _on_play_pressed)
	level_selector_button.connect("pressed", _on_level_selector_pressed)
	close.connect("pressed", _on_close_pressed)
	level_button_1.connect("pressed", _on_level_1_pressed)
	level_button_2.connect("pressed", _on_level_2_pressed)
	load_game.connect("pressed", _on_load_pressed)
	
	
func _on_load_pressed():
	LevelManager.load_game()
	success_load.visible = true
	
func _on_level_1_pressed():
	LevelManager.current_level = 0
	success.visible = true
	
func _on_level_2_pressed():
	LevelManager.current_level = 1
	success.visible = true
	print("Level 2 selected")
	
func _on_close_pressed():
	level_selector.visible = false
	
func _on_level_selector_pressed():
	level_selector.visible = true
	success.visible = false
	
func _on_play_pressed():
	print("Starting Game...")
	LevelManager.reload_current_level()
	
