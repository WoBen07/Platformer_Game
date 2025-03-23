extends Container

@onready var button: Button = $Button
@onready var shop: CanvasLayer = $"../Shop"
@onready var close: Button = $"../Shop/Close"
@onready var add_life: Button = $"../Shop/add_life"
@onready var heart_4: AnimatedSprite2D = $"../Control/HeartContainer/Heart4"
@onready var not_enough: Label = $"../Shop/Not_enough"
@onready var success: Label = $"../Shop/success"
@onready var maximum_amount: Label = $"../Shop/Maximum_amount"
@onready var max_heart_label: Label = $"../Shop/max_heart_label"

var clicked_before = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.connect("pressed", _on_shop_pressed)
	close.connect("pressed", _on_close_pressed)
	add_life.connect("pressed", _on_add_life_pressed)

func _on_add_life_pressed():
	if clicked_before:
		max_heart_label.visible = true
		return
	if LevelManager.coin_checkpoint >= 10:
		LevelManager.coin_checkpoint -= 10
		clicked_before = true
		heart_4.visible = true
		LevelManager.lives += 1
		LevelManager.maxLives += 1
		success.visible = true
		maximum_amount.text = "0/1"
		print("Bought lives, max lives: ", LevelManager.maxLives)
		print(LevelManager.lives)
	else:
		not_enough.visible = true
	
		
func _on_shop_pressed():
	print("Shop pressed")
	shop.visible = true
	
func _on_close_pressed():
	shop.visible = false
	not_enough.visible= false
	success.visible = false
	max_heart_label.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
