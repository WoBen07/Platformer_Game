extends Control

@onready var heart_1: AnimatedSprite2D = $HeartContainer/Heart1
@onready var heart_2: AnimatedSprite2D = $HeartContainer/Heart2
@onready var heart_3: AnimatedSprite2D = $HeartContainer/Heart3
@onready var heart_4: AnimatedSprite2D = $HeartContainer/Heart4
@onready var coins_bank: Label = $coins_bank
@onready var coins_add: Label = $coins_add
@onready var menu: Button = $"../Menu"
@onready var menu_2: Popup = $"../Menu2"
@onready var close: Button = $"../Menu2/Panel/close"
@onready var main_menu: Button = $"../Menu2/Panel/Main_menu"
@onready var save: Button = $"../Menu2/Panel/Save"
@onready var load: Button = $"../Menu2/Panel/Load"
@onready var success: Label = $"../Menu2/Panel/success"
@onready var load_dialoge: Panel = $"../Menu2/Panel/Load_Dialoge"
@onready var yes_load: Button = $"../Menu2/Panel/Load_Dialoge/yes_load"
@onready var no_load: Button = $"../Menu2/Panel/Load_Dialoge/no_load"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.player:
		Globals.player.connect("health_changed", _on_health_changed)
	else:
		print("Player not found")
	menu.connect("pressed", _on_menu_pressed)
	close.connect("pressed", _on_close_pressed)
	main_menu.connect("pressed", _on_main_menu_pressed)
	save.connect("pressed", _on_safe_pressed)
	load.connect("pressed", _on_load_pressed)
	yes_load.connect("pressed", _on_yes_load_pressed)
	no_load.connect("pressed", _on_no_load_pressed)
	
func _on_no_load_pressed():
	load_dialoge.visible = false
	
func _on_yes_load_pressed():
	LevelManager.load_game()
	LevelManager.reload_current_level()

func _on_load_pressed():
	load_dialoge.visible = true
	
func _on_safe_pressed():
	success.visible = true
	LevelManager.save_game()
	
func _on_menu_pressed():
	menu_2.visible = true
	
func _on_close_pressed():
	menu_2.visible = false
	success.visible = false
	load_dialoge.visible = false
	
func _on_main_menu_pressed():
	LevelManager.load_main_menue()
	
func _on_health_changed(lives):
	if Globals.player.max_lives == 4:
		if lives == 3:
			heart_1.play()
		elif lives == 2:
			heart_2.play()
		elif lives == 1:
			heart_3.play()
		else:
			heart_4.play()
	else:
		if lives == 2:
			heart_1.play()
		elif lives == 1:
			heart_2.play()
		else:
			heart_3.play()
		
		
func _process(delta: float) -> void:
	coins_bank.text = "%d" % [LevelManager.coin_checkpoint]
	coins_add.text = "+%d" % [LevelManager.collected_coins]
	
