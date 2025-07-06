extends Resource

class_name Recruit

@export var test:String = "test"

@export var r_name:String
@export var r_img:String
#@export var c_img: String
@export var strg: String
@export var dex: String
@export var intel: String
@export var ctr: String
@export var spd: String
@export var crd: String
@export var skill1:Dictionary
@export var skill2:Dictionary
@export var skill3:Dictionary
@export var skill4:Dictionary
@export var max_health: String
@export var max_resc: String
@export var clas: Dictionary
@export var race: Dictionary
@export var team:String
@export var cur_health: String
@export var cur_resc: String
@export var rank = "Recruit"
@export var wins = "0"
@export var losses = "0"
var f_dmg:int = 0
var p_dmg:float = 1.00
var effects: Array = []
var skills: Array = []
var ui





func _init(name_in = "" ,rc_img_in = "",c_img_in = "",strg_in = 1,dex_in = 1,intel_in = 1,ctr_in = 1,spd_in = 1,crd_in = 1,skill1_in = global.skills[0],skill2_in = global.skills[0],skill3_in = global.skills[0],skill4_in = global.skills[0],max_health_in = 1,max_resc_in = 1,team = "", c = global.classes[0], r = global.races[0]):
	r_name = name_in
	r_img = rc_img_in
	#c_img = c_img_in
	strg = str(strg_in)
	dex = str(dex_in)
	intel = str(intel_in)
	ctr = str(ctr_in)
	spd = str(spd_in)
	crd = str(crd_in)
	skills.append(skill1_in)
	skill1 = inst_to_dict(skill1_in)
	skills.append(skill2_in)
	skill2 = inst_to_dict(skill2_in)
	skills.append(skill3_in)
	skill3 = inst_to_dict(skill3_in)
	skills.append(skill4_in)
	skill4 = inst_to_dict(skill4_in)
	clas = inst_to_dict(c)
	race = inst_to_dict(r)
	max_health = str(max_health_in)
	max_resc = str(max_resc_in)
	global.recruits.append(self)
	print("SUCCESS!!!!!")
	
	
	
