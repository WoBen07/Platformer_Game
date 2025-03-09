extends Control

@onready var heart_1: AnimatedSprite2D = $HeartContainer/Heart1
@onready var heart_2: AnimatedSprite2D = $HeartContainer/Heart2
@onready var heart_3: AnimatedSprite2D = $HeartContainer/Heart3
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.player:
		Globals.player.connect("health_changed", _on_health_changed)
	else:
		print("Player not found")
func _on_health_changed(lives):
	if lives == 2:
		heart_1.play()  # Play the first heart animation
	elif lives == 1:
		heart_2.play()  # Play the second heart animation
	elif lives == 0:
		heart_3.play()
		
func _process(delta: float) -> void:
	label.text = "%d" % [LevelManager.collected_coins]
