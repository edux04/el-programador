extends Area2D

@onready var plataformer_game_manager: Node = %PlataformerGameManager


func _on_body_entered(_body: Node2D) -> void:
	queue_free()
	plataformer_game_manager.add_point()
