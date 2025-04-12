extends Area2D

@onready var plataformer_game_manager: Node = get_node("/root/Platformer/PlataformerGameManager")

func _on_body_entered(body: Node2D) -> void:
	#var y_delta = body.position.y - get_parent().global_position.y
	var x_delta = body.position.x - get_parent().global_position.x
	if body.velocity.y > 0:
		var lives=get_parent().lives
		get_parent().lives=lives-1
		if(get_parent().lives==0):
			get_parent().queue_free()
		body.jump()
	else:
		plataformer_game_manager.decrease_live()
		if (x_delta > 0):
			body.play_damage_animation(800)
		else:
			body.play_damage_animation(-800)
