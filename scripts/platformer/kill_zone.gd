extends Area2D

@onready var timer: Timer = $Timer
@onready var plataformer_game_manager: Node = %PlataformerGameManager


func _on_body_entered(_body: Node2D) -> void:
	timer.start()
	
func _on_timer_timeout() -> void:
	plataformer_game_manager.decrease_live()
