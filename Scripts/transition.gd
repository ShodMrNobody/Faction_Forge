extends CanvasLayer

	
	
func _ready() -> void:
	layer = -100
	
@export var transition_duration: float = .2  # Duration of the fade transition
# Transition function to switch scenes with fade effect
func transition_to_scene(scene_path: String) -> void:
	# Bring CanvasLayer to the front by setting a high layer value
	layer = 100  # Adjust to a value that is above other layers in your scene

	# Set ColorRect opacity to fully transparent at the start
	$Panel/ColorRect.modulate.a = 0.0

	# Create a tween for fade-out animation
	var tween = create_tween()
	tween.tween_property($Panel/ColorRect, "modulate:a",1.0, transition_duration)

	# Wait for fade-out to finish, then change the scene
	await tween.finished
	get_tree().change_scene_to_file(scene_path)

	# Create a new tween for fade-in animation
	tween = create_tween()
	tween.tween_property($Panel/ColorRect, "modulate:a", 0.0, transition_duration)

	# Wait for the fade-in to complete, then move CanvasLayer back behind
	layer = -100
	await tween.finished
	  # Move CanvasLayer to the background, adjust as needed
