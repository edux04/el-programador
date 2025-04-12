extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		# Cambia a la escena especificada
		get_tree().change_scene_to_file("res://scenes/house/house.tscn")
