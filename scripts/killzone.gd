extends Area2D

@onready var timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	LevelManager.load_restart_menu()
		
	


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	
