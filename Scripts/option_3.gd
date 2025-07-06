extends Panel
@onready var char_name = $VBoxContainer/HBoxContainer/center/Label
@onready var name_background = $name_background
@onready var char_image = $char_image
@onready var bottom_image = $bottom_image
@onready var health_bar = $VBoxContainer/HBoxContainer/health
@onready var health_text = $VBoxContainer/HBoxContainer/health/Label
@onready var resc_bar = $VBoxContainer/HBoxContainer/resource
@onready var resc_text = $VBoxContainer/HBoxContainer/resource/Label
@onready var resc_texture
@onready var sex = $VBoxContainer/HBoxContainer/center/sex_race_class/sex
@onready var race = $VBoxContainer/HBoxContainer/center/sex_race_class/race
@onready var clas = $VBoxContainer/HBoxContainer/center/sex_race_class/class
@onready var abilities = $VBoxContainer/HBoxContainer/center/abilities
@onready var strg = $VBoxContainer/HBoxContainer/center/stats/strg
@onready var dex = $VBoxContainer/HBoxContainer/center/stats/dex
@onready var intel = $VBoxContainer/HBoxContainer/center/stats/intel
@onready var ctr = $VBoxContainer/HBoxContainer/center/stats/ctr
@onready var spd = $VBoxContainer/HBoxContainer/center/stats/spd
@onready var crd = $VBoxContainer/HBoxContainer/center/stats/crd
@onready var rank  = $VBoxContainer/HBoxContainer/center/rank_wins_loses/rank
@onready var wins = $VBoxContainer/HBoxContainer/center/rank_wins_loses/wins
@onready var losses = $VBoxContainer/HBoxContainer/center/rank_wins_loses/loses
@onready var bio = $VBoxContainer/bio
var backstory = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bio.text = "BIO: " + backstory
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var temp 
	var ok = global.copy_node_from_other_tscn("res://Scenes/menus/verify.tscn","warning")
	#var warning = global.copy_node_from_other_tscn("res://Scenes/verify.tscn","warning")
	for recruit in global.recruits:
		if recruit.r_name == char_name.text && recruit.race.rc_name == race.text && recruit.clas.c_name == clas.text && recruit.rank == rank.text && str(recruit.strg) == strg.text && str(recruit.dex) == dex.text && str(recruit.intel) == intel.text && str(recruit.ctr) == ctr.text && str(recruit.spd) == spd.text && str(recruit.crd) == crd.text:
			temp = recruit
			ok.warning = "WARNING: IF YOU CLICK OK THIS CHARACTER WILL BE DELETED (UNTILL you can rescan the character card)"
			ok.r = temp
			ok.card = self
			self.get_parent().get_parent().add_child(ok)

	pass # Replace with function body.
