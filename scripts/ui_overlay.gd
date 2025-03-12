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



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.player:
		Globals.player.connect("health_changed", _on_health_changed)
	else:
		print("Player not found")
	menu.connect("pressed", _on_menu_pressed)
	close.connect("pressed", _on_close_pressed)
	main_menu.connect("pressed", _on_main_menu_pressed)
	
func _on_menu_pressed():
	menu_2.visible = true
	
func _on_close_pressed():
	menu_2.visible = false
	
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
	
