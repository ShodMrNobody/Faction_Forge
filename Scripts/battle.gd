extends Control


@onready var team_1_full = $ReferenceRect/Team_1_full2/Team_1_full/Team_1
@onready var team_2_full = $ReferenceRect/Team_2_full/VBoxContainer/Team_2
@onready var ready_t1 = $"ReferenceRect/Battle Controls/ReadyButton"
@onready var ready_t2 = $"ReferenceRect/Battle Controls/ReadyButton2"
@onready var t1_members = []
@onready var t2_members = []
@onready var t1_combo_bar = $ReferenceRect/Team_1_full2/Team_1_full/HBoxContainer/ComboBar
@onready var t2_combo_bar = $ReferenceRect/Team_2_full/VBoxContainer/HBoxContainer/ComboBar
@onready var t1_full_bars = $ReferenceRect/Team_1_full2/Team_1_full/HBoxContainer/ComboBar/Label
@onready var t2_full_bars = $ReferenceRect/Team_2_full/VBoxContainer/HBoxContainer/ComboBar/Label


var idle = load("res://Styles/idle.tres")
var attacking = load("res://Styles/attacking_member.tres")
var targeted = load("res://Styles/target_member.tres")
var strg_icon_load =load ("res://Scenes/Icons/strg_icon.tscn")
var strg_icon = strg_icon_load.instantiate()
var dex_icon_load = load("res://Scenes/Icons/dex_dmg.tscn")
var dex_icon = dex_icon_load.instantiate()
var intel_icon_load = load("res://Scenes/Icons/intel_icon.tscn")
var intel_icon = intel_icon_load.instantiate()
var crit_icon_load = load("res://Scenes/Icons/crit_icon.tscn")
var crit_icon = crit_icon_load.instantiate()
var uni_icon_load = load("res://Scenes/Icons/universal_icon.tscn")
var uni_icon = uni_icon_load.instantiate()
var heal_icon_load = load("res://Scenes/Icons/heal_icon.tscn")
var heal_icon = heal_icon_load.instantiate()
var cleared = false




signal attack_finished

var participants = []
var skills = []
var current_turn = 0
var turn_order_initialized = false
var sk_func_ref
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	build_teams(team_1_full, global.team_1)
	build_teams(team_2_full, global.team_2)
	initialize_turn_order()
	
	global.team_1.clear()
	global.team_2.clear()

func _process(delta: float) -> void:
	if ready_t1.text == "Ready" && ready_t2.text == "Ready":
		print("FIGHT!!!")
		ready_t1.text = "Not Ready"
		ready_t1.add_theme_stylebox_override("normal",load("res://Styles/not_ready.tres"))
		ready_t2.text = "Not Ready"
		ready_t2.add_theme_stylebox_override("normal",load("res://Styles/not_ready.tres"))
		start_battle()





func start_battle():
	cleared = false
	if not turn_order_initialized:
		initialize_turn_order()
	current_turn = 0
	for mem in participants:
		var tar = mem.ui.tar_list.get_selected()
		var tar_name = mem.ui.tar_list.get_item_text(tar)
		var skill = mem.ui.skill_list.get_selected()
		
		for tars in participants:
			for i in range(mem.skills.size()):
				if tars.r_name == tar_name && i == skill:
					if mem.team == "1":
						deal_damage(mem,tars,mem.skills[i],t1_combo_bar,t1_full_bars)
					elif mem.team == "2":
						deal_damage(mem,tars,mem.skills[i],t2_combo_bar,t2_full_bars)
					await attack_finished
					if mem == participants[participants.size() - 1]:
						end_round(participants)

func start_turn(me,tar,sk):
	var combo = int(t1_full_bars.text) + (t1_combo_bar.value/100)
	me.ui.add_theme_stylebox_override("panel",attacking)
	tar.ui.add_theme_stylebox_override("panel",targeted)
	#resource_checks(me,tar,sk)
	# add things here for it to happen every round before damage is calculated
	return combo

func deal_damage(me,tar,sk,combo_bar,full_bars) -> void:
	if int(me.cur_health) > 0:
		if int(me.cur_resc) >= sk.s_resource_cost:
			print("started")
			print("in team")
			await create_tween().tween_interval(.5).finished
			var active = me.ui.effects_panel.get_children()
			var combo = start_turn(me,tar,sk)
			
			for each in active:
				if each.type == "stun" or "stun" in each.stats_to_change:
					print("STUNNED!!")
					end_turn(me,tar,sk)
					return
			for i in range (int(sk.s_num_hits)):
				# add here to make something happen on every hit
				dmg_calc(me,tar,sk,combo)
				combo_checks(combo_bar,full_bars,sk)
				if sk.e != null:
					sk.e.on_apply(me,tar,sk.effect)
					sk_func_ref = sk.e
				for each in active:
					if each.target == tar && each.type == "mark":
						each.active_effect.remove_effect(each,me)
				await create_tween().tween_interval(2).finished
				
				if i == (int(sk.s_num_hits) - 1):
					end_turn(me,tar,sk)
			
			await attack_finished
		else:
			print("FAILED!!")
	else:
		print("IS DEAD!")
	

	



func dmg_calc(me,tar,sk,combo):
	var type
	var tot_dmg
	var strg_dmg = int(sk.s_dmg)  * int(me.strg)  * combo
	var dex_dmg = int(sk.s_dmg)  * int(me.dex)  * combo
	var intel_dmg = int(sk.s_dmg)  * int(me.intel)  * combo
	var ctr_dmg = int(sk.s_dmg)  * (int(me.ctr) + int(tar.ctr))
	dict_to_inst(me.clas)
	#print("start battle stats")
	#print(combo)
	#print(sk.s_name)
	#print(me.r_name)
	#print(sk.s_dmg_type)
	#print(me.strg)
	#print(tar.strg)
	#print(me.clas.c_strg_mod)
	#print(sk.s_dmg)
	#print(sk.s_num_hits)
	#print(strg_dmg,"pre_strg")
	#print(dex_dmg,"pre_dex")
	#print(intel_dmg,"pre_intel")
	#print(tot_dmg,"pre_tot_dmg")

	if sk.s_dmg_type == "Physical":
		strg_dmg = strg_dmg / int(tar.strg)
		dex_dmg = 0
		intel_dmg = 0
		type = strg_icon
	elif sk.s_dmg_type == "Skillful":
		dex_dmg = dex_dmg / int(tar.dex)
		strg_dmg = 0
		intel_dmg = 0
		type = dex_icon
	elif sk.s_dmg_type == "Magical":
		intel_dmg = intel_dmg / int(tar.intel)
		dex_dmg = 0
		strg_dmg = 0
		type = intel_icon
	elif sk.s_dmg_type == "Control":
		ctr_dmg = ctr_dmg / int(tar.ctr)
		#print(ctr_dmg,"ctr")
	elif sk.s_dmg_type == "Universal" or sk.s_dmg_type == "All":
		type = uni_icon
	elif sk.s_dmg_type == "Heal":
		type = heal_icon
	
	
	tot_dmg = strg_dmg + dex_dmg + intel_dmg + me.f_dmg * me.p_dmg
	#print(strg_dmg,"strg")
	#print(dex_dmg,"dex")
	#print(intel_dmg,"intel")
	#print(tot_dmg,"tot_dmg")
	#print("tot_dmg ends")
	#to change targets health/resc
	
	dmg_icon(me,tar,sk,combo,type,tot_dmg)
	
	#await create_tween().tween_interval(2).finished
	
	tar.cur_health = str(int(tar.cur_health) - int(tot_dmg))
	if int(me.cur_health) > int(me.max_health):
		me.cur_health = str(me.max_health)
	if int(tar.cur_health) > int(tar.max_health):
		tar.cur_health = str(tar.max_health)
	if int(me.cur_health) < 0:
		me.cur_health = str(0)
	if int(tar.cur_health) < 0:
		tar.cur_health = str(0)
	tar.ui.health_text.text = global.vert_string(str(tar.cur_health) + "/" + str(tar.max_health))
	tar.ui.health_bar.value = int(tar.cur_health)
	
	return str(int(tot_dmg))
	
	
	 
	#to change self health/resc will have to modify accordingly
	#me.cur_health = me.cur_health + sk.s_dmg
	#me.hp.text = str(me.max_health) + " / " + str(me.cur_health)
	
	
func dmg_icon(me,tar,sk,combo,icon_inst,dmg):
	
	icon_inst = icon_inst.duplicate() 
	tar.ui.dmg.add_child(icon_inst)
	icon_inst.label.text = str(int(dmg))
	
	stat_update(me)
	stat_update(tar)
	pass

func end_turn(me,tar,sk):
	#add things here to make things happen once per round after damage is calculated

	for hit in tar.ui.dmg.get_children():
		hit.queue_free()
	
	me.ui.add_theme_stylebox_override("panel",idle)
	tar.ui.add_theme_stylebox_override("panel",idle)
	emit_signal("attack_finished")

func end_round(participants):
	print("round end")
	for mem in participants:
		for sk in mem.skills:
			if cleared == false:
				cleared = true
				sk.e.round_end(participants)
		stat_update(mem)
	#ready_t1.text = "Not Ready"
	#ready_t1.add_theme_stylebox_override("normal",load("res://Styles/not_ready.tres"))
	#ready_t2.text = "Not Ready"
	#ready_t2.add_theme_stylebox_override("normal",load("res://Styles/not_ready.tres"))

func combo_checks(combo_bar,full_bars,sk):
	var change = sk.s_combo_generated 
	combo_bar.value = change + combo_bar.value
	if combo_bar.value == 100:
		full_bars.text = str(int(full_bars.text) + 1)
		combo_bar.value = 1
	if combo_bar.value == 0:
		full_bars.text = str(int(full_bars.text) - 1)
		combo_bar.value = 99
		

func resource_checks(me,tar,sk):
	me.cur_resc = str(int(me.cur_resc) - int(sk.s_resource_cost))
	if int(me.cur_resc) > int(me.max_resc):
		me.cur_resc = me.max_resc
	if int(tar.cur_resc) > int(tar.max_health):
		tar.cur_resc = tar.max_health
	if int(me.cur_resc) < 0:
		me.cur_resc = 0
	if int(tar.cur_resc) < 0:
		tar.cur_resc = 0
	me.ui.resc_text.text = global.vert_string( str(me.cur_resc) + "/" + str(me.max_resc))
	me.ui.resc_bar.value = int(me.cur_resc)
	



func _on_t1_ready_button_pressed() -> void:
	ready_state(ready_t1)

func _on_t2_ready_button_pressed() -> void:
	ready_state(ready_t2)

func ready_state(pressed):
	if pressed.text == "Not Ready":
		pressed.text = "Ready"
		pressed.add_theme_stylebox_override("normal",load("res://Styles/ready.tres"))
	elif pressed.text == "Ready":
		pressed.text = "Not Ready"
		pressed.add_theme_stylebox_override("normal",load("res://Styles/not_ready.tres"))
			
func build_teams(team: Node, members: Array):
	for mem in members:
		for recruit in global.recruits:
			if mem == recruit.r_name:
				#added HBOX container in team_member.tscn as a parent of both team_members broke this. remove this when fixed. 
				var member = global.copy_node_from_other_tscn("res://Scenes/team_member.tscn", "member_updated")
				participants.append(recruit) 
				team.add_child(member)
				
				recruit.cur_health = str(int(recruit.max_health))
				recruit.cur_resc = str(int(recruit.max_resc))
				recruit.skills[0] = dict_to_inst(recruit.skill1)
				if recruit.skill1.e != null and recruit.skill1.e is Dictionary:
					recruit.skill1.e = dict_to_inst(recruit.skill1.e)
					recruit.skills[0] = recruit.skill1
				recruit.skills[1] = dict_to_inst(recruit.skill2)
				if recruit.skill2.e != null:
					recruit.skill2.e = dict_to_inst(recruit.skill2.e)
					recruit.skills[1] = recruit.skill2
				recruit.skills[2] = dict_to_inst(recruit.skill3)
				if recruit.skill3.e != null:
					recruit.skill3.e = dict_to_inst(recruit.skill3.e)
					recruit.skills[2] = recruit.skill3
				recruit.skills[3] = dict_to_inst(recruit.skill4)
				if recruit.skill4.e != null:
					recruit.skill4.e = dict_to_inst(recruit.skill4.e)
					recruit.skills[3] = recruit.skill4
				recruit.ui = member
				recruit.ui.skill_list.clear()
				recruit.ui.tar_list.clear()
				recruit.ui.health_bar.max_value = int(recruit.max_health)
				recruit.ui.resc_bar.max_value = int(recruit.max_resc)
				recruit.ui.char_name.text = recruit.r_name  
				recruit.ui.skill_list.add_item(recruit.skill1.s_name)
				recruit.ui.skill_list.add_item(recruit.skill2.s_name)
				recruit.ui.skill_list.add_item(recruit.skill3.s_name)
				recruit.ui.skill_list.add_item(recruit.skill4.s_name)
				stat_update(recruit)
				
				
				#TO-DO add universal skills for all characters
				#for skill in global.skills:
				#	if skill.s_name == "First Aid":
				#		recruit.skill_list.add_item(skill.s_name)
				if team == team_1_full:
					t1_members.append(recruit)
					recruit.team = "1"
					for tars in global.team_2:
						recruit.ui.tar_list.add_item(tars)
					for tars in global.team_1:
						recruit.ui.tar_list.add_item(tars)
				else:
					recruit.team = "2"
					t2_members.append(recruit)
					for tars in global.team_1:
						recruit.ui.tar_list.add_item(tars)
					for tars in global.team_2:
						recruit.ui.tar_list.add_item(tars)
				
func stat_update(recruit):
	recruit.ui.strg.text = str(recruit.strg)
	recruit.ui.dex.text = str(recruit.dex)
	recruit.ui.intel.text = str(recruit.intel)
	recruit.ui.ctr.text = str(recruit.ctr)
	recruit.ui.spd.text = str(recruit.spd)
	recruit.ui.crd.text = str(recruit.crd)
	recruit.ui.health_text.text = global.vert_string(recruit.cur_health + "/" + recruit.max_health)
	recruit.ui.health_bar.value = int(recruit.cur_health)
	recruit.ui.resc_text.text  = global.vert_string(recruit.max_resc + "/" + recruit.cur_resc)
	recruit.ui.resc_bar.value = int(recruit.cur_resc)

	# Initialize turn order after all participants are added


func initialize_turn_order():
	# Sort participants by speed (highest to lowest)
	participants.sort_custom(
		func(a, b):
			return a.spd > b.spd
	)
	
	# Update turn order labels for all participants
	for i in range(participants.size()):
		participants[i].ui.turn.text = str(i + 1)
	
	turn_order_initialized = true

func find_turn_label(recruit) -> Label:
	# Search through team 1
	for member in team_1_full.get_children():
		if member.get_child(2).get_child(1).get_child(1).text == recruit.r_name:
			return member.get_child(2).get_child(2).get_child(0).get_child(1)
	
	# Search through team 2
	for member in team_2_full.get_children():
		if member.get_child(2).get_child(0).get_child(1).text == recruit.r_name:
			return member.get_child(2).get_child(2).get_child(1).get_child(1)
	
	return null
			
			
