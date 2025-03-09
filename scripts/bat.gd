extends Node2D

@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D  # Accessing PathFollow2D child of Path2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite  # Accessing the AnimatedSprite

var speed = 100.0  # Speed at which the bat moves along the path (float value)
var direction = 1.0  # Direction of movement (1.0 for forward, -1.0 for backward)

func _ready():
	path_follow.offset = 0.0  # Reset to the start of the path (start point)
	path_follow.path = $Path2D  # Reference to the Path2D node

	# Optional: Looping path movement, set to true if you want the bat to go back to the start after reaching the end
	path_follow.loop = true

func _process(delta):
	# Update the PathFollow2D position along the path
	path_follow.offset += direction * speed * delta / path_follow.path_length  # Use path_length to scale speed

	# Flip the sprite depending on the movement direction
	if direction == 1.0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true

	# Optional: You can add behavior here to reverse direction, change speed, etc.
