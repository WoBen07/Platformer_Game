extends Area2D



func _on_body_entered(body: Node2D) -> void:
	print("Enemy hit")
	body.player_is_hit()
		
