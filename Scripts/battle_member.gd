extends Panel
@onready var background_img = $char_image
@onready var name_bg = $TextureRect
@onready var turn = $VBoxContainer/HBoxContainer/turn_order/Label
@onready var health_bar = $VBoxContainer/center/health
@onready var health_text = $VBoxContainer/center/health/Label
@onready var resc_bar = $VBoxContainer/center/resource
@onready var resc_text = $VBoxContainer/center/resource/Label
@onready var resc_texture 
@onready var skill_list = $VBoxContainer/center/VBoxContainer/OptionButton
@onready var tar_list = $VBoxContainer/center/VBoxContainer/OptionButton2
@onready var char_image = $char_image
@onready var char_name = $VBoxContainer/HBoxContainer/name
@onready var active_effects_panel = $effects_panel
@onready var effects_panel = $effects_panel/VScrollBar/effects
@onready var stats_panel = $stats_panel
@onready var strg = $stats_panel/stats/strg
@onready var dex =$stats_panel/stats/dex
@onready var intel = $stats_panel/stats/intel   
@onready var ctr = $stats_panel/stats/ctr
@onready var spd = $stats_panel/stats/spd
@onready var crd = $stats_panel/stats/crd
@onready var dmg = $dmg_panel/dmg

var base_strg
var base_dex
var base_intel
var base_ctr
var base_spd
var base_crd




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	active_effects_panel.visible = false
	stats_panel.visible = false
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_effects_pressed() -> void:
	if active_effects_panel.visible == false:
		active_effects_panel.visible = true
		stats_panel.visible = false
	else:
		active_effects_panel.visible = false
	pass # Replace with function body.


func _on_stats_pressed() -> void:
	if stats_panel.visible == false:
		stats_panel.visible = true
		active_effects_panel.visible = false
	else:
		stats_panel.visible = false

	pass # Replace with function body.
