extends Resource

class_name Effect

var e_name: String
var icon
var m_stacks: int
var c_stacks: int = 0
var stats_to_change: Dictionary
var stacks_on_apply:int
var expire_condition:Array
#on hit , struck , rounds, 
var type: String
#DOT,BLAST,BUFF,DEBUFF,STATUS
var expire: bool
var m_rounds: int
var c_rounds: int
var negative: bool
var add_effects: Dictionary
var tier: int = 1

func _init(e_name,scene,stats_to_change,m_rounds,expire_condition,stacks_on_apply,type,negative,add_effects):
	self.icon = load(scene)
	self.e_name = e_name
	self.m_stacks = m_stacks
	self.stats_to_change = stats_to_change
	self.stacks_on_apply = stacks_on_apply
	self.expire_condition = expire_condition
	self.expire = expire
	self.m_rounds = tier
	self.negative = negative
	self.type = type
	self.c_stacks = 1
	self.add_effects = add_effects
	global.effects.append(self)
	pass


func on_apply(me,tar,t): 
	for e in t:
		for effect in global.effects:
			if effect.e_name == e:
				var icon = effect.icon.instantiate()
				var dupped = icon.duplicate()
				var active = tar.ui.effects_panel.get_children()
				dupped.tier = t[e]
				dupped.active_effect = effect
				dupped.expire_condition = effect.expire_condition
				dupped.type = effect.type
				dupped.target = me
				dupped.add_effects = effect.add_effects
				dupped.stats_to_change = effect.stats_to_change
				for each in active:
					if each.active_effect == dupped.active_effect:
						remove_effect(each,tar)
				if stacks_on_apply == 0:
					stacks_on_apply = 1
				c_stacks = ((0 + stacks_on_apply) * dupped.tier)
				tar.effects.append(effect)
				tar.ui.effects_panel.add_child(dupped)
				dupped.stacks.text = str(c_stacks)
				for extra in effect.add_effects:
					for se in global.effects:
						if extra == se.e_name:
							for ne in se.stats_to_change:
								if ne not in dupped.stats_to_change:
									dupped.stats_to_change[ne] = se.stats_to_change[ne]

				for stat in dupped.stats_to_change:
					print(stat)
					if effect.negative == false:
						raise_stats(stat,tar,dupped.stats_to_change[stat])
					else:
						lower_stats(stat,tar,dupped.stats_to_change[stat])
				
					
				
func raise_stats(stat,tar,change):
	if stat == "all":
		tar.strg = str(int(tar.strg) + change)
		tar.dex = str(int(tar.dex) + change)
		tar.intel = str(int(tar.intel) + change)
		tar.ctr = str(int(tar.ctr) + change)
		tar.spd = str(int(tar.spd) + change)
		tar.crd = str(int(tar.crd) + change)
	elif stat == "str":
			tar.strg = str(int(tar.strg) + change)
	elif stat == "dex":
		tar.dex = str(int(tar.dex) + change)
	elif stat == "intel":
		tar.intel = str(int(tar.intel) + change)
	elif stat == "ctr":
		tar.ctr = str(int(tar.ctr) + change)
	elif stat == "spd":
		tar.spd = str(int(tar.spd) + change)
	elif stat == "crd":
		tar.crd = str(int(tar.crd) + change)

	pass

func remove_effect(each,tar):
	tar.ui.effects_panel.remove_child(each)
	tar.effects.erase(each.active_effect)
	for stat in each.active_effect.stats_to_change:
		lower_stats(stat,tar,each.stats_to_change[stat])
	

func lower_stats(stat,tar,change):
		if stat == "all":
			tar.strg = str(int(tar.strg) - change)
			tar.dex = str(int(tar.dex) - change)
			tar.intel = str(int(tar.intel) - change)
			tar.ctr = str(int(tar.ctr) - change)
			tar.spd = str(int(tar.spd) - change)
			tar.crd = str(int(tar.crd) - change)
		elif stat == "str":
			tar.strg = str(int(tar.strg) - change)
		elif stat == "dex":
			tar.dex = str(int(tar.dex) - change)
		elif stat == "intel":
			tar.intel = str(int(tar.intel) - change)
		elif stat == "ctr":
			tar.ctr = str(int(tar.ctr) - change)
		elif stat == "spd":
			tar.spd = str(int(tar.spd) - change)
		elif stat == "crd":
			tar.crd = str(int(tar.crd) - change)
			

func round_begin():
	
	pass
	
func round_end (participants):
	for mem in participants:
		var active = mem.ui.effects_panel.get_children()
		for each in active:
			each.stacks.text = str(int(each.stacks.text) - 1)
			if "dot" in each.type:
				if "f_dmg" in each.stats_to_change:
					mem.cur_health = (str(int(mem.cur_health) - each.stats_to_change["f_dmg"]))
				if "p_dmg" in each.stats_to_change:
					mem.cur_health = (str(int(mem.cur_health) - each.stats_to_change["p_dmg"]))
					
			if each.stacks.text == str(0):
				if each.type != "mark":
					remove_effect(each,mem)
	pass
	

func turn_begin():
	pass

func turn_end():
	pass
	
func on_hit(effect,me,tar):
	print("effect on hit")
	if effect.type == "mark":
		remove_effect(effect,me)
	pass

func on_attack():
	pass
