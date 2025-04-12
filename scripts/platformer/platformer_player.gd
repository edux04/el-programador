extends CharacterBody2D

const WALK_SPEED = 130.0
const RUN_SPEED = 220.0
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

var jump_count = 0
const MAX_JUMPS = 2

func jump():
	velocity.y = JUMP_VELOCITY
	jump_count += 1

func play_damage_animation(x):
	velocity.x = x
	animated_sprite.play("death")

func _physics_process(delta):
	# Gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# Restablecer conteo de saltos al tocar suelo
	if is_on_floor():
		jump_count = 0

	# Saltar (primer salto siempre permitido, doble salto solo si final_response es "no")
	if Input.is_action_just_pressed("jump"):
		if jump_count == 0:  # Primer salto siempre permitido
			jump()
		elif jump_count < MAX_JUMPS and GameManager.final_response == "no":  # Doble salto condicional
			print(GameManager.final_response)  # Para depuración
			jump()

	# Dirección horizontal
	var direction = Input.get_axis("left", "right")

	# Correr solo si final_response es "no", de lo contrario solo caminar
	var current_speed = WALK_SPEED
	if GameManager.final_response == "no" and Input.is_action_pressed("run"):
		current_speed = RUN_SPEED

	# Movimiento horizontal
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)

	# Flip del sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Animaciones
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("side_idle")
		else:
			animated_sprite.play("side_walk")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("falling")

	move_and_slide()
