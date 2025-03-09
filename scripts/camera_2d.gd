extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


@onready var player = $"../../Player"  # Adjust the path if needed

func _process(delta):
	position = position.lerp(player.position, 8 * delta)  # Smooth follow
