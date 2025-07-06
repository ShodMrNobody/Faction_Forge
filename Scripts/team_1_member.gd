extends VBoxContainer

@onready var hp_bar = $HP
@onready var hp = $HP/Label
@onready var rp_bar = $MP
@onready var rp = $MP/Label
@onready var tar_list = $Targets
@onready var skill_list = $Skills
@onready var img = $CenterContainer/Icon
@onready var r_name = $CenterContainer/Name/r_name 
@onready var turn = $CenterContainer/Turn_order/Turn/Label2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
