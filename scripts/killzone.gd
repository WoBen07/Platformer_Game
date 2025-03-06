extends Area2D

@onready var timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	print("Player hit")
	if body.has_method("player_is_hit"):
		body.player_is_hit()
		
	


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	
