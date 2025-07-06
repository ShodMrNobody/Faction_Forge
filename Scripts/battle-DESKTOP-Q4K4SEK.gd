extends Control

@onready var team_1_full = $ReferenceRect/Team_1_full2/Team_1_full/Team_1
@onready var team_2_full = $ReferenceRect/Team_2_full/VBoxContainer/Team_2
@onready var ready_t1 = $"ReferenceRect/Battle Controls/ReadyButton"
@onready var ready_t2 = $"ReferenceRect/Battle Controls/ReadyButton2"
@onready var t1_members = []
@onready var t2_members = []
@onready var t1_combo_bar = $ReferenceRect/Team_1_full2/Team_1_full/ComboBar
@onready var t2_combo_bar = $ReferenceRect/Team_2_full/VBoxContainer/ComboBar
@onready var t1_full_bars = $ReferenceRect/Team_1_full2/Team_1_full/ComboBar/Label
@onready var t2_full_bars = $ReferenceRect/Team_2_full/VBoxContainer/ComboBar/Label

var participants = []
var skills = []
var current_turn = 0
var turn_order_initialized = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	build_teams(team_1_full, global.team_1)
	build_teams(team_2_full, global.team_2)
	initialize_turn_order()
	
	global.team_1.clear()
	global.team_2.clear()

func build_teams(team: Node, members: Array):
	for mem in members:
		for recruit in global.recruits:
			if team == team_1_full && mem == recruit.r_name:
				
				var member = global.copy_node_from_other_tscn("res://Scenes/team_member.tscn", "team_1_member")
				recruit.cur_health = recruit.max_health
				
				recruit.hp = member.get_child(4).get_child(0)
				recruit.hp_bar = member.get_child(4)
				recruit.rp = member.get_child(3).get_child(0)
				recruit.rp_bar = member.get_child(3)
				recruit.tar_list = member.get_child(0)
				recruit.skill_list = member.get_child(1)
				recruit.img = member.get_child(2).get_child(0)
				member.get_child(2).get_child(1).get_child(1).text = recruit.r_name
				recruit.turn = member.get_child(2).get_child(2).get_child(0).get_child(1)
				recruit.team = "1"
				recruit.ui = member
				recruit.cur_resc = recruit.max_resc
				
				participants.append(recruit) 
				t1_members.append(recruit)
				team.add_child(member)
				
				recruit.skill_list.clear()
				recruit.skill_list.add_item(recruit.skill1.s_name)
				recruit.skill_list.add_item(recruit.skill2.s_name)
				recruit.skill_list.add_item(recruit.skill3.s_name)
				recruit.skill_list.add_item(recruit.skill4.s_name)
				recruit.tar_list.clear()
				
				for tars in global.team_2:
					recruit.tar_list.add_item(tars)
				for tars in global.team_1:
					recruit.tar_list.add_item(tars)
					
				
				recruit.hp.text = str(recruit.max_health) + " / " + str(recruit.cur_health)
				recruit.hp_bar.max_value = recruit.max_health
				recruit.hp_bar.value = recruit.cur_health
				recruit.rp_bar.max_value = recruit.max_resc
				recruit.rp_bar.value = recruit.max_resc
				recruit.rp.text = str(recruit.max_resc) + " / " + str(recruit.cur_resc)
			elif team == team_2_full && mem == recruit.r_name:
				var member = global.copy_node_from_other_tscn("res://Scenes/team_member.tscn", "team_2_member")
				recruit.hp = member.get_child(0).get_child(0)
				recruit.hp_bar = member.get_child(0)
				recruit.rp = member.get_child(1).get_child(0)
				recruit.rp_bar = member.get_child(1)
				recruit.tar_list = member.get_child(4)
				recruit.skill_list = member.get_child(3)
				recruit.img = member.get_child(2).get_child(1)
				recruit.r_name = member.get_child(2).get_child(0).get_child(1).text
				recruit.turn = member.get_child(2).get_child(2).get_child(1).get_child(1) 
				#var max_health = recruit.max_health
				#var cur_health = recruit.max_health
				#var cur_resc = recruit.max_resc
				#var max_resc = recruit.max_resc
				#var hp = member.get_child(0).get_child(0)
				#var hp_bar = member.get_child(0)
				#var rp = member.get_child(1).get_child(0)
				#var rp_bar = member.get_child(1)
				#var tar_list = member.get_child(4)
				#var skill_list = member.get_child(3)
				#var img = member.get_child(2).get_child(1)
				#var r_name = member.get_child(2).get_child(0).get_child(1)
				#var turn = member.get_child(2).get_child(2).get_child(1).get_child(1)
				
				recruit.team = "2"
				recruit.ui = member
				recruit.cur_health = recruit.max_health
				recruit.cur_resc = recruit.max_resc
				
				participants.append(recruit)
				team.add_child(member)
				t2_members.append(recruit)
				
				recruit.skill_list.clear()
				recruit.skill_list.add_item(recruit.skill1.s_name)
				recruit.skill_list.add_item(recruit.skill2.s_name)
				recruit.skill_list.add_item(recruit.skill3.s_name)
				recruit.skill_list.add_item(recruit.skill4.s_name)
				recruit.tar_list.clear()
				
				for tars in global.team_1:
					for rec in global.recruits:
						if rec.r_name == tars:
							recruit.tar_list.add_item(tars)
				for tars in global.team_2:
					for rec in global.recruits:
						if rec.r_name == tars:
							recruit.tar_list.add_item(tars)
				
				
				recruit.hp.text = str(recruit.max_health) + " / " + str(recruit.cur_health)
				print(recruit.hp)
				recruit.hp_bar.max_value = recruit.max_health
				recruit.hp_bar.value = recruit.max_health
				recruit.rp.text = str(recruit.max_resc) + " / " + str(recruit.cur_resc)
				recruit.rp_bar.max_value = recruit.max_resc
				recruit.rp_bar.value = recruit.max_resc

	
	# Initialize turn order after all participants are added


func initialize_turn_order():
	# Sort participants by speed (highest to lowest)
	participants.sort_custom(
		func(a, b):
			return a.spd > b.spd
	)
	
	# Update turn order labels for all participants
	for i in range(participants.size()):
		var recruit = participants[i]
		recruit.turn.text = str(i + 1)
	
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

func _process(delta: float) -> void:
	if ready_t1.text == "Ready" && ready_t2.text == "Ready":
		print("FIGHT!!!")
		ready_t1.text = "Not Ready"
		ready_t1.add_theme_stylebox_override("normal",load("res://Styles/not_ready.tres"))
		ready_t2.text = "Not Ready"
		ready_t2.add_theme_stylebox_override("normal",load("res://Styles/not_ready.tres"))
		start_battle()

func start_battle():
	if not turn_order_initialized:
		initialize_turn_order()
	current_turn = 0
	for mem in participants:
		#print(mem.hp)
		#print(mem.hp.text)
		mem.cur_health = 3
		mem.hp.text = str(mem.max_health) + " / " + str(mem.cur_health)
		print(mem.hp)
		
		mem.hp_bar.value = mem.cur_health

		var tar = mem.tar_list.get_selected()
		var tar_name = mem.tar_list.get_item_text(tar)
		var skill = mem.skill_list.get_selected()
		var skill_name = mem.skill_list.get_item_text(skill)
		
		deal_damage(mem.team,tar_name,skill_name)
	#for mems in participants:
	#	for mem in team_2_full.get_children():
	#		var r_name = mem.get_child(2).get_child(0).get_child(1).text
	#		var tars = mem.get_child(4)
	#		var tar = tars.get_selected()
	#		var tar_name = tars.get_item_text(tar)
	#		var skills = mem.get_child(3)
	#		var skill = skills.get_selected()
	#		var skill_name = skills.get_item_text(skill)
	#		var team = mems.team
	#		if r_name == mems.r_name:
	#			deal_damage(team,tar_name,skill_name)
				


func deal_damage(team,tar,sk):
	if team == "1":
		for skill in global.skills:
			if sk == skill.s_name:
				#print(skill.s_dmg)
				#print(t1_combo_bar.value)
				pass
				var change = skill.s_combo_generated - skill.s_combo_cost
				t1_combo_bar.value = change + t1_combo_bar.value
				if t1_combo_bar.value == 100:
					t1_full_bars.text = str(int(t1_full_bars.text) + 1)
					t1_combo_bar.value = 1
				if t1_combo_bar.value == 0:
					t1_full_bars.text = str(int(t1_full_bars.text) - 1)
					t1_combo_bar.value = 99
	elif team == "2":
		for skill in global.skills:
			if sk == skill.s_name:
				var change = skill.s_combo_generated - skill.s_combo_cost
				t2_combo_bar.value = change + t2_combo_bar.value
				if t2_combo_bar.value == 100:
					t2_full_bars.text = str(int(t2_full_bars.text) + 1)
					t2_combo_bar.value = 1
				if t2_combo_bar.value == 0:
					t2_full_bars.text = str(int(t2_full_bars.text) - 1)
					t2_combo_bar.value = 99
			

	# Add your battle start logic here

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
			
			
			
