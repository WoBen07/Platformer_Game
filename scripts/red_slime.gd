extends Node2D

@onready var left: RayCast2D = $Left
@onready var right: RayCast2D = $Right
@onready var down: RayCast2D = $Down
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var speed = 50
var multiplier = 1.5
var direction = 1
var original_scale

func _ready() -> void:
	original_scale = animated_sprite.scale

func _process(delta: float) -> void:
	# Move enemy properly
	position.x += direction * speed * delta  

	# Detect walls and turn around
	if right.is_colliding() or left.is_colliding():
		flip_direction()

	# Detect edges and turn around
	if not down.is_colliding():
		#flip_direction()
		pass

func flip_direction():
	direction *= -1  # Reverse direction
	animated_sprite.flip_h = not animated_sprite.flip_h  # Flip sprite

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("body entered")
		animated_sprite.scale = original_scale * multiplier

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		animated_sprite.scale = original_scale
