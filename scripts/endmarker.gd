extends Area2D

var has_triggered = false

func _on_body_entered(body: Node2D) -> void:
	if has_triggered:
		return  # Ignore extra triggers
	has_triggered = true
	print("Body entered:", body.name)
	LevelManager.call_deferred("next_level")
