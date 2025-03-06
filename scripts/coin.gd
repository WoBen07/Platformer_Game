extends Area2D

@onready var pick_up_animation: AnimationPlayer = $PickUpAnimation



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pick_up_animation.play("PickUp")
		LevelManager.collected_coins += 1
		
	
