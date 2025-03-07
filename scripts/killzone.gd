extends Area2D

@onready var timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("respawn"):
		body.respawn()
		
	


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	
