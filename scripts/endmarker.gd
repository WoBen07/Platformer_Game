extends Area2D

var has_triggered = false
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var finish: AudioStreamPlayer2D = $Finish


func _on_body_entered(body: Node2D) -> void:
	if has_triggered:
		return  # Ignore extra triggers
	has_triggered = true
	print("Body entered:", body.name)
	if body.has_method("reached_end"):
		body.reached_end()
	animated_sprite.play("finish")
	finish.play()
	 # Wait for both animation and sound to finish before moving to next level
	finish.connect("finished", _call_next_level)

# Call next level after both animation and sound finished
func _call_next_level():
	LevelManager.call_deferred("next_level")
