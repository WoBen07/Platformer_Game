extends ParallaxLayer



@onready var sprite: Sprite2D = $Sprite2D
@onready var parallax_layer_2: ParallaxLayer = $"."


func _ready():
	if sprite.texture:
		print("Texture width:", sprite.texture.get_size().x)
		parallax_layer_2.motion_mirroring.x = sprite.texture.get_size().x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
