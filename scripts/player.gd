extends CharacterBody2D

signal health_changed(lives)

@onready var animated_sprite: AnimatedSprite2D = $Sprite
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var audio_stream_player: AudioStreamPlayer2D = $Die
@onready var hit: AudioStreamPlayer2D = $Hit
@onready var heart_1: AnimatedSprite2D = $HeartContainer/Heart1
@onready var heart_2: AnimatedSprite2D = $HeartContainer/Heart2
@onready var heart_3: AnimatedSprite2D = $HeartContainer/Heart3
@onready var heart_container: Node2D = $HeartContainer
@onready var spawn_point = global_position

var is_dead = false
var is_loading_next_level = false
var is_invincable = false
const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var controls_disabled = false

func get_lives():
	return LevelManager.lives

func get_max_lives():
	return LevelManager.maxLives

func _ready():
	
	add_to_group("player")

func respawn():
	if get_lives() > 0:
		LevelManager.lives -= 1
		global_position = spawn_point
		update_lives()
		make_invincable()
	else:
		player_die()
		
func update_lives():
	if get_lives() > 0:
		emit_signal("health_changed", get_lives())
		animated_sprite.play("hit")
		hit.play()

	else:
		emit_signal("health_changed", get_lives())
		#heart_3.play()
		animated_sprite.play("hit")
		player_die()
		LevelManager.deaths += 1
		Engine.time_scale = 1.0
		return
		
func make_invincable():
	animated_sprite.modulate = Color(1, 1, 1, 0.5)  # Make semi-transparent
	$InvincibilityTimer.start()

func player_is_hit():
	Engine.time_scale = 0.5
	if is_dead or is_invincable:  
		return  
	is_invincable = true
	LevelManager.lives -= 1
	update_lives()
	if is_invincable:
		make_invincable()
		
func _on_invincibility_timer_timeout():
	# Re-enable collision after invincibility ends
	is_invincable = false
	Engine.time_scale = 1.0
	animated_sprite.modulate = Color(1, 1, 1, 1)  # Restore normal appearance

func reached_end():
	if controls_disabled:
		return  
	controls_disabled = true  
	heart_container.visible = false
	velocity.x = 0  # Stop horizontal movement
	animated_sprite.play("finish")
	
	await get_tree().create_timer(3.0).timeout  # Wait a second
	controls_disabled = false  # Re-enable movement (if needed)
	heart_container.visible = true

func player_die():
		if is_dead:
			return
		is_dead = true
		collision_shape_2d.queue_free()
		# Play death sound
		audio_stream_player.play()

		# Play death animation
		animated_sprite.play("die")

		# Wait for the animation to finish
		await animated_sprite.animation_finished

		# Wait for the sound to finish (optional, if it's longer than the animation)
		await audio_stream_player.finished
		Engine.time_scale = 1.0
		LevelManager.load_restart_menu()
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if is_dead:
		return
		
	if is_loading_next_level:
		return
		
	if animated_sprite.animation == "hit" and not animated_sprite.frame == animated_sprite.sprite_frames.get_frame_count("hit") - 1:
		return  # Wait until hit animation is finished
	
	if controls_disabled:
		move_and_slide()
		return
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	#Fip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	#play animations
	
	
	#Applys movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
