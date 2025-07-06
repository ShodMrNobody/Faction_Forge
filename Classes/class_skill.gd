extends Resource


class_name Skill
var s_name: String
var s_class: String
var s_race: String  
var s_resource_type: String
var s_resource_cost: int
var s_combo_generated: float
var s_spd_change: float
var s_num_hits: int
var s_dmg: int
var s_dmg_type: String
var s_skill_desc: String
var e
var effect:Dictionary

func _init(name = " ",clas ="",race = "",resource_type = "",resource_cost = 0,combo_generated = .00,spd_change = .00, num_hits = 1, dmg = 0, dmg_type = "Physical", skill_desc = "",effect = null):
	self.s_name = name
	self.s_class = clas
	self.s_race = race
	self.s_resource_type = resource_type
	self.s_resource_cost = resource_cost
	self.s_combo_generated = combo_generated
	self.s_spd_change = spd_change
	self.s_num_hits = num_hits
	self.s_dmg = dmg
	self.s_dmg_type = dmg_type
	self.s_skill_desc = skill_desc
	if effect != null:
		self.effect = effect
		for key in effect.keys():
			for e in global.effects:
				if key == e.e_name:
					self.e = inst_to_dict(e)
	global.skills.append(self)
	
