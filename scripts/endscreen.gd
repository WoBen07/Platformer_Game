extends Control

@onready var restart_button = $CanvasLayer/Restart
@onready var main_menu_button = $CanvasLayer/Main_menu
@onready var info: Label = $CanvasLayer/Info


func _ready():
	# Connect buttons to functions
	restart_button.connect("pressed", _on_restart_pressed)
	main_menu_button.connect("pressed", _on_main_menu_pressed)
	info.text = "You died %d times and collected %d coins" % [LevelManager.deaths, LevelManager.coin_checkpoint]

func _on_restart_pressed():
	print("Restarting level...")
	LevelManager.reload_current_level()

func _on_main_menu_pressed():
	print("Going to main menu...")
	LevelManager.current_level = 0  # Reset level index
	LevelManager.load_main_menue()
