extends CenterContainer

var credits = []
@export var display_duration: float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	credits = [$VBoxContainer.get_child(0), $VBoxContainer.get_child(1)]
	for label in credits: label.visible = false
	start_credits_animation()
	
	
	


func start_credits_animation():
	var delay = 0.0
	for label in credits:
		await (get_tree().create_timer (delay).timeout)
		label.visible = true
		animate_fade_in(label)
		delay += display_duration
		
		await get_tree().create_timer(display_duration).timeout
	Transition.transition_to_scene("res://Scenes/main_menu.tscn")

func animate_fade_in(label):
	var tween = create_tween()  # Create the tween with create_tween()
	
	# Start fully transparent
	label.modulate = Color(1, 1, 1, 0)
	
	# Tween the 'modulate.a' property to 1 over 1.0 seconds
	tween.tween_property(label, "modulate:a", 1.0, 1.0)
	
	# Set the transition and easing separately
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
