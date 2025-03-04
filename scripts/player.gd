extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite: AnimatedSprite2D = $Sprite
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D


var is_dead = false

func player_die():
	if is_dead:
		return
	is_dead = true
	audio_stream_player.play()
	animated_sprite.play("hit")
	
	animated_sprite.animation_finished.connect(_on_hit_animation_finished)
	
func _on_hit_animation_finished():
	if animated_sprite.animation == "hit":
		animated_sprite.play("die")
		animated_sprite.animation_finished.connect(_on_die_animation_finished)

func _on_die_animation_finished():
	if animated_sprite.animation == "die":
		collision_shape_2d.queue_free()  # Remove collision after death animation
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if is_dead:
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
