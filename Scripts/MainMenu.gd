extends Control

@onready var team_options = $ScrollContainer/team_options
@onready var team_1 = $ScrollContainer/team_options/team_1_op
@onready var team_2 = $ScrollContainer/team_options/team_2_op
@onready var fight_menu = $"ScrollContainer/team_options/Fight!"
@onready var t_1_mem_1 = $"ScrollContainer/team_options/Fight!/team_1/mem1"
@onready var t_1_mem_2 = $"ScrollContainer/team_options/Fight!/team_1/mem2"
@onready var t_1_mem_3 = $"ScrollContainer/team_options/Fight!/team_1/mem3"
@onready var t_1_mem_4 = $"ScrollContainer/team_options/Fight!/team_1/mem4"
@onready var t_1_mem_5 = $"ScrollContainer/team_options/Fight!/team_1/mem5"
@onready var t_1_mem_6 = $"ScrollContainer/team_options/Fight!/team_1/mem6"
@onready var t_2_mem_1 = $"ScrollContainer/team_options/Fight!/team_2/mem1"
@onready var t_2_mem_2 = $"ScrollContainer/team_options/Fight!/team_2/mem2"
@onready var t_2_mem_3 = $"ScrollContainer/team_options/Fight!/team_2/mem3"
@onready var t_2_mem_4 = $"ScrollContainer/team_options/Fight!/team_2/mem4"
@onready var t_2_mem_5 = $"ScrollContainer/team_options/Fight!/team_2/mem5"
@onready var t_2_mem_6 = $"ScrollContainer/team_options/Fight!/team_2/mem6"
@onready var team_1_mem = [t_1_mem_1.text , t_1_mem_2.text, t_1_mem_3.text, t_1_mem_4.text, t_1_mem_5.text, t_1_mem_6.text]
@onready var team_2_mem = [t_2_mem_1.text, t_2_mem_2.text, t_2_mem_3.text, t_2_mem_4.text, t_2_mem_5.text, t_2_mem_6.text]

 

var fight 
var member = "temp"
var countt1 = 0
var countt2 = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.load_roster()
	
	$Menu/HBoxContainer/Skirmish.hide()
	$Menu/HBoxContainer/War.hide()
	$Menu/HBoxContainer/Play.show()
	
	team_options.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_pressed() -> void:
	$Menu/HBoxContainer/Skirmish.show()
	$Menu/HBoxContainer/War.show()
	$Menu/HBoxContainer/Play.hide()

func _on_skirmish_pressed() -> void:
	
	fight = "skirmish"
	gen_ops()
	
	
	#Transition.transition_to_scene("res://Scenes/battle.tscn")

func _on_war_pressed() -> void:
	fight = "war"
	gen_ops()
	
func gen_ops():
	if team_options.visible == false: 
		team_options.show()
		
		
		for i in global.recruits:
			var team_option = HBoxContainer.new()
			var option = Label.new()
			var selected = CheckButton.new()
			
			option.text = i.r_name
			option.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			selected.toggled.connect(add_members.bind(selected))
			
			team_1.add_child(team_option)
			team_option.add_child(option)
			team_option.add_child(selected)
		for i in global.recruits:
			var team_option = HBoxContainer.new()
			var option = Label.new()
			var selected = CheckButton.new()
			
			option.text = i.r_name
			option.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			selected.toggled.connect(add_members.bind(selected))
			
			team_2.add_child(team_option)
			team_option.add_child(option)
			team_option.add_child(selected)
	else:
		team_options.hide()
		fight = ""
		countt1 = 0
		countt2 = 0
		var temp_team_1  = team_1.get_children()
		var temp_team_2 = team_2.get_children()
		for mem in temp_team_1:  
			team_1.remove_child(mem)
			find_and_replace(team_1_mem,mem.get_child(0).text)
			
			
			
		for mem in temp_team_2:
			team_2.remove_child(mem)
			find_and_replace(team_2_mem,mem.get_child(0).text)
				
				
		t_1_mem_1.text = ""
		t_1_mem_2.text = ""
		t_1_mem_3.text = ""
		t_1_mem_4.text = ""
		t_1_mem_5.text = ""
		t_1_mem_6.text = ""
		t_2_mem_1.text = ""
		t_2_mem_2.text = ""
		t_2_mem_3.text = ""
		t_2_mem_4.text = ""
		t_2_mem_5.text = ""
		t_2_mem_6.text = ""
			
	
	#Transition.transition_to_scene("res://Scenes/battle.tscn")

func add_members(this,selected):

	var team = selected.get_parent().get_parent()
	var temp = selected.get_parent().get_child(0).text
	
	if this == true && team.name == team_1.name:
		for mem in team_1_mem:
			if fight == "skirmish" && countt1 == 3:
				selected.set_pressed_no_signal(false)
				return countt1
			elif fight == "war" && countt2 == 6:
				selected.set_pressed_no_signal(false)
				return countt1
		make_teams(team_1_mem, temp)
		countt1 = countt1 + 1
	
	elif this == true && team.name == team_2.name:
		for mem in team_2_mem:
			if fight == "skirmish" && countt2 == 3:
				selected.set_pressed_no_signal(false)
				return countt2
			elif fight == "war" && countt2 == 6:
				selected.set_pressed_no_signal(false)
				return countt2
		make_teams(team_2_mem, temp)
		print(team_2_mem, "team 2")
		countt2 = countt2 + 1
	elif this == false && team.name == team_1.name: 
		find_and_replace(team_1_mem,temp)
		countt1 = countt1 - 1
	elif this == false && team.name == team_2.name:
		find_and_replace(team_2_mem,temp)
		countt2 = countt2 - 1
		
		
		


func make_teams(team, mem):
	
	var slot_1 = team[0]
	var slot_2 = team[1]
	var slot_3 = team[2]
	var slot_4 = team[3]
	var slot_5 = team[4]
	var slot_6 = team[5]
	
	if slot_1 == "":
		team[0] = mem
	elif slot_2 == "":
		team[1] = mem
	elif slot_3 == "":
		team[2] = mem
	elif slot_4 == "" && fight == "war":
		team[3] = mem
	elif slot_5 == "" && fight == "war":
		team[4] = mem
	elif slot_6 == "" && fight == "war":
		team[5] = mem
		
	if team == team_1_mem:
		t_1_mem_1.text = team[0]
		t_1_mem_2.text = team[1]
		t_1_mem_3.text = team[2]
		t_1_mem_4.text = team[3]
		t_1_mem_5.text = team[4]
		t_1_mem_6.text = team[5]
	elif team == team_2_mem:
		t_2_mem_1.text = team[0]
		t_2_mem_2.text = team[1]
		t_2_mem_3.text = team[2]
		t_2_mem_4.text = team[3]
		t_2_mem_5.text = team[4]
		t_2_mem_6.text = team[5]
				
				

func find_and_replace( replace, find):
		var at = replace.find(find)
		if at != -1:
			replace[at] = ""
			
			
func _on_fight_pressed() -> void:
	
	### Changed t_1_mem_1 && t_2_mem_1 for testing. original value t_2_mem_3 && t_1_mem_3
	if fight == "skirmish" && t_1_mem_1.text != "" && t_2_mem_1.text != "":
		
		Team.new(
			"Home",
			t_1_mem_1.text, 
			t_1_mem_2.text, 
			t_1_mem_3.text, 
			t_1_mem_4.text, 
			t_1_mem_5.text, 
			t_1_mem_6.text,
			"team_1")       
		Team.new(
			"Away",
			t_2_mem_1.text, 
			t_2_mem_2.text, 
			t_2_mem_3.text, 
			t_2_mem_4.text, 
			t_2_mem_5.text, 
			t_2_mem_6.text,
			"team_2")       
		Transition.transition_to_scene("res://Scenes/menus/battle.tscn")
		
		
	elif fight == "war" && t_1_mem_6.text != "" && t_2_mem_6.text != "":
		Team.new(
			"Home",
			t_1_mem_1.text, 
			t_1_mem_2.text, 
			t_1_mem_3.text, 
			t_1_mem_4.text, 
			t_1_mem_5.text, 
			t_1_mem_6.text,
			"team_1")       
			
		Team.new(
			"Away",
			t_2_mem_1.text, 
			t_2_mem_2.text, 
			t_2_mem_3.text, 
			t_2_mem_4.text, 
			t_2_mem_5.text, 
			t_2_mem_6.text,
			"team_2")
		Transition.transition_to_scene("res://Scenes/menus/battle.tscn")
	pass # Replace with function body.
	
	

	
func _on_duty_roster_pressed() -> void:
	Transition.transition_to_scene("res://Scenes/menus/duty_roster.tscn")


func _on_history_pressed() -> void:
	Transition.transition_to_scene("res://Scenes/menus/history.tscn")


func _on_medical_tent_pressed() -> void:
	Transition.transition_to_scene("res://Scenes/menus/medical_tent.tscn")


func _on_new_recruit_pressed() -> void:
	Transition.transition_to_scene("res://Scenes/menus/new_recruit.tscn")

func _on_faction_forge_pressed() -> void:
	Transition.transition_to_scene("res://Scenes/menus/faction_forge.tscn")
