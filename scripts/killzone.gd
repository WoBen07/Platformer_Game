extends Area2D

@onready var timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	print("You died")
	Engine.time_scale = 0.5
	if body.has_method("player_die"):
		body.player_die()  # Call the player's death function
	timer.stop()
	timer.start()
	


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	LevelManager.call_deferred("reload_current_level")
