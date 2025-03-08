extends AudioStreamPlayer2D
@onready var music: AudioStreamPlayer2D = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music.play()


func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		music.stop()
