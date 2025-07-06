extends Control  # or the base node of your scene

func _on_back_pressed() -> void:
		Transition.transition_to_scene("res://Scenes/main_menu.tscn")
