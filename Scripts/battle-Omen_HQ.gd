extends Control

@onready var team_1_full = $ReferenceRect/Team_1_full2/Team_1_full/Team_1
@onready var team_2_full = $ReferenceRect/Team_2_full/VBoxContainer/Team_2
@onready var ready_t1 = $"ReferenceRect/Battle Controls/ReadyButton"
@onready var ready_t2 = $"ReferenceRect/Battle Controls/ReadyButton2"
@onready var t1_members = []
@onready var t2_members = []

var participants = []
var skills = []
var current_turn = 0
var turn_order_initialized = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	build_teams(team_1_full, global.team_1)
	build_teams(team_2_full, global.team_2)
	global.team_1.clear()
	global.team_2.clear()

func build_teams(team: Node, members: Array):
	for mem in members:
		for recruit in global.recruits:
			if team == team_1_full && mem == recruit.r_name:
				var cur_health = recruit.health
				var cur_resc = recruit.resc
				var member = global.copy_node_from_other_tscn("res://Scenes/team_member.tscn", "team_1_member")
				var hp = member.get_child(4).get_child(0)
				var rp = member.get_child(3).get_child(0)
				var tar_list = member.get_child(0)
				var skill_list = member.get_child(1)
				var img = member.get_child(2).get_child(0)
				var r_name = member.get_child(2).get_child(1).get_child(1)
				var turn = member.get_child(2).get_child(2).get_child(0).get_child(1)
				
				participants.append(recruit)
				t1_members.append(recruit)
				team.add_child(member)
				
				skill_list.clear()
				skill_list.add_item(recruit.skill1.s_name)
				skill_list.add_item(recruit.skill2.s_name)
				skill_list.add_item(recruit.skill3.s_name)
				skill_list.add_item(recruit.skill4.s_name)
				tar_list.clear()
				
				for tars in global.team_2:
					for rec in global.recruits:
						if rec.r_name == tars:
							tar_list.add_item(tars)
				for tars in global.team_1:
					for rec in global.recruits:
						if rec.r_name == tars:
							tar_list.add_item(tars)
				
				r_name.text = recruit.r_name
				hp.text = str(recruit.health) + " / " + str(cur_health)
				rp.text = str(recruit.resc) + " / " + str(cur_resc)
				
			elif team == team_2_full && mem == recruit.r_name:
				var member = global.copy_node_from_other_tscn("res://Scenes/team_member.tscn", "team_2_member")
				var cur_health = recruit.health
				var cur_resc = recruit.resc
				var hp = member.get_child(0).get_child(0)
				var rp = member.get_child(1).get_child(0)
				var tar_list = member.get_child(4)
				var skill_list = member.get_child(3)
				var img = member.get_child(2).get_child(1)
				var r_name = member.get_child(2).get_child(0).get_child(1)
				var turn = member.get_child(2).get_child(2).get_child(1).get_child(1)
				
				participants.append(recruit)
				team.add_child(member)
				t2_members.append(recruit)
				
				skill_list.clear()
				skill_list.add_item(recruit.skill1.s_name)
				skill_list.add_item(recruit.skill2.s_name)
				skill_list.add_item(recruit.skill3.s_name)
				skill_list.add_item(recruit.skill4.s_name)
				tar_list.clear()
				
				for tars in global.team_1:
					for rec in global.recruits:
						if rec.r_name == tars:
							tar_list.add_item(tars)
				for tars in global.team_2:
					for rec in global.recruits:
						if rec.r_name == tars:
							tar_list.add_item(tars)
				
				r_name.text = recruit.r_name
				hp.text = str(recruit.health) + " / " + str(cur_health)
				rp.text = str(recruit.resc) + " / " + str(cur_resc)
	
	# Initialize turn order after all participants are added
	if not turn_order_initialized:
		initialize_turn_order()

func initialize_turn_order():
	# Sort participants by speed (highest to lowest)
	participants.sort_custom(
		func(a, b):
			return a.spd > b.spd
	)
	
	# Update turn order labels for all participants
	for i in range(participants.size()):
		var recruit = participants[i]
		var turn_label = find_turn_label(recruit)
		if turn_label:
			turn_label.text = str(i + 1)
	
	turn_order_initialized = true
	print("Turn order initialized:", participants)

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
			
			
			
	
		
