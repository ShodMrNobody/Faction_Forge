extends Panel
@onready var message =  $message

var ok: bool
var r 
var card
var warning
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	message.text = warning
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ok_pressed() -> void:
	self.queue_free()
	if r is Recruit:
		card.queue_free()
		global.recruits.erase(r)
		global.save_roster()
	#global.recruits.erase(r)
	pass # Replace with function body.


func _on_cancel_pressed() -> void:
	self.queue_free()
	pass # Replace with function body.
