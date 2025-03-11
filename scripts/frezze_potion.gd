extends Area2D
@onready var splash: AnimatedSprite2D = $Splash
@onready var timer: Timer = $Timer
@onready var sound_effect: AudioStreamPlayer2D = $SoundEffect
@onready var frozen_overlay: CanvasLayer = $FrozenOverlay
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var frozen_effect_triggered = false

func _process(delta: float) -> void:
	if Globals.player.lives == 0 and LevelManager.is_frozen:
		_cancel_frezze_effect()
func _on_body_entered(body: Node2D) -> void:
	if frozen_effect_triggered:
		return
	splash.play()
	sound_effect.play()
	frozen_overlay.visible= true
	LevelManager.is_frozen = true
	timer.start()


func _on_timer_timeout() -> void:
	LevelManager.is_frozen = false
	frozen_overlay.visible = false


func _on_splash_animation_finished() -> void:
	splash.visible = false
	collision_shape.disabled = true
	
func _cancel_frezze_effect():
	LevelManager.is_frozen = false
	timer.stop()
	frozen_overlay.visible = false
