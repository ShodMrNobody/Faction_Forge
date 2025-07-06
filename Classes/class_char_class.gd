extends Resource

class_name char_class
var c_name: String
var c_strg_mod: float
var c_dex_mod: float
var c_intel_mod: float
var c_con_mod: float
var c_spd_mod: float
var c_cord_mod: float
var c_health_mod:float
var c_resc_mod:float
var c_skills: Array 




func _init (name = "", strg_mod = 0, dex_mod = 0, intel_mod = 0, con_mod = 0, spd_mod = 0, cord_mod = 0,health_mod = .00,resc_mod = .00, class_skills = []):
	self.c_name = name
	self.c_strg_mod = strg_mod
	self.c_dex_mod = dex_mod
	self.c_intel_mod = intel_mod
	self.c_con_mod = con_mod
	self.c_spd_mod = spd_mod
	self.c_cord_mod = cord_mod
	self.c_health_mod = health_mod
	self.c_resc_mod = resc_mod
	self.c_skills = class_skills 
	global.classes.append(self)

	
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass
