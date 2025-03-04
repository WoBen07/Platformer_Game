extends Area2D

@onready var timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	print("You died")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()
	


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	LevelManager.call_deferred("instantiate_level", LevelManager.current_level - 1)
