extends Control

@onready var heart_1: AnimatedSprite2D = $HeartContainer/Heart1
@onready var heart_2: AnimatedSprite2D = $HeartContainer/Heart2
@onready var heart_3: AnimatedSprite2D = $HeartContainer/Heart3
@onready var heart_4: AnimatedSprite2D = $HeartContainer/Heart4
@onready var coins_bank: Label = $coins_bank
@onready var coins_add: Label = $coins_add



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.player:
		Globals.player.connect("health_changed", _on_health_changed)
	else:
		print("Player not found")
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
	
