extends Area2D

@onready var dialog_box_scene = preload("res://scenes/dialog_box.tscn")
var dialog_instance

func _ready():
	if dialog_instance == null:
		dialog_instance = dialog_box_scene.instantiate()
		get_tree().current_scene.add_child.call_deferred(dialog_instance)
	GameManager.current_scene_name = get_tree().current_scene.name

func show_next_dialog():
	var data = GameManager.get_next_dialog()
	if data["text"] == "":
		return
	
	dialog_instance.show_dialog(data["text"], data["is_last"], show_next_dialog)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print(get_tree().current_scene.name)
		show_next_dialog()

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		dialog_instance.hide_dialog()
