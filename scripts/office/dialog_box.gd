extends CanvasLayer

@onready var label = $Panel/Label
@onready var continue_btn = $Panel/ContinueButton
@onready var yes_btn = $Panel/YesButton
@onready var no_btn = $Panel/NoButton

var on_continue_callback: Callable = Callable()

func _ready():
	continue_btn.pressed.connect(_on_continuar_pressed)
	yes_btn.pressed.connect(_on_si_pressed)
	no_btn.pressed.connect(_on_no_pressed)
	hide()

func show_dialog(text: String, is_last: bool = false, callback: Callable = Callable()):
	if label:
		label.text = text
	else:
		print("⚠️ El nodo Label no se encontró.")
	on_continue_callback = callback
	
	continue_btn.visible = !is_last
	yes_btn.visible = is_last
	no_btn.visible = is_last
	
	show()

func hide_dialog():
	hide()

func _on_continuar_pressed():
	hide()
	if on_continue_callback.is_valid():
		on_continue_callback.call()

func _on_si_pressed():
	hide()
	GameManager.save_response("si")
	if on_continue_callback.is_valid():
		on_continue_callback.call()

func _on_no_pressed():
	hide()
	GameManager.save_response("no")
	if on_continue_callback.is_valid():
		on_continue_callback.call()
