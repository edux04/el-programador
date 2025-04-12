extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		# Carga la escena empaquetada (ajusta la ruta a tu escena)
		var next_scene=preload("res://scenes/office/office.tscn")
		# Cambia a la escena especificada
		get_tree().call_deferred("change_scene_to_packed", next_scene)
