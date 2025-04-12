extends Node


var current_scene_name := ""
var dialog_index := 0
var final_response := "si"

var dialogs = {
	"Office": [
		"Hola, Edu. Te piden que desarrolles un algoritmo que recopile datos personales de los usuarios (como ubicación, hábitos de navegación y contactos)...",
		"sin su consentimiento explícito, para venderlos a anunciantes y aumentar los ingresos de la empresa.",
		"¿Implementarías el algoritmo sabiendo que compromete la privacidad de los usuarios?"
	]
}

func get_current_dialogs() -> Array:
	return dialogs.get(current_scene_name, [])

func get_next_dialog() -> Dictionary:
	var d = get_current_dialogs()
	if dialog_index < d.size():
		var text = d[dialog_index]
		var is_last = dialog_index == d.size() - 1
		dialog_index += 1
		return {
			"text": text,
			"is_last": is_last
		}
	return {"text": "", "is_last": false}

func reset_dialog():
	dialog_index = 0
	final_response = ""

func save_response(answer: String):
	final_response = answer
	print("Respuesta guardada:", final_response)
	
	
