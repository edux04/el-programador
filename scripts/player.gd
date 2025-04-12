extends CharacterBody2D

var speed = 100  # speed in pixels/sec

@onready var animated_sprite = $AnimatedSprite2D  # Referencia al nodo AnimatedSprite2D

func _physics_process(_delta):
	# Obtener la dirección del movimiento
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	
	# Actualizar la animación según el movimiento
	update_animation(direction)
	
	# Mover el personaje
	move_and_slide()

func update_animation(direction: Vector2):
	if direction == Vector2.ZERO:
		if animated_sprite.animation.begins_with("side"):
			animated_sprite.play("side_idle")
		elif animated_sprite.animation.begins_with("front"):
			animated_sprite.play("front_idle")
		elif animated_sprite.animation.begins_with("back"):
			animated_sprite.play("back_idle")
		else:
			animated_sprite.play("side_idle")
	else:
		if abs(direction.x) > abs(direction.y):
			animated_sprite.play("side_walk")
			animated_sprite.flip_h = direction.x < 0
		elif direction.y < 0:
			animated_sprite.play("back_walk")
		elif direction.y > 0:
			animated_sprite.play("front_walk")
