extends Control

@onready var r_img = $Picture/VBoxContainer/RaceImage
@onready var c_img = $Picture/VBoxContainer/RaceImage/ClassImage
@onready var skill_container = $SkillsContainer/VBoxContainer/HBoxContainer/ScrollContainer/SkillTabContainer
@onready var race_option = $Picture/VBoxContainer/Picture_I/Race
@onready var class_option = $Picture/VBoxContainer/Picture_I/Class
@onready var r_skill_option = $SkillsContainer/VBoxContainer/HBoxContainer/ScrollContainer/SkillTabContainer/RaceSkill
@onready var c_skill_option = $SkillsContainer/VBoxContainer/HBoxContainer/ScrollContainer/SkillTabContainer/ClassSkill
@onready var u_skill_option = $SkillsContainer/VBoxContainer/HBoxContainer/ScrollContainer/SkillTabContainer/UniversalSkill
@onready var sp_skill_option = $SkillsContainer/VBoxContainer/HBoxContainer/ScrollContainer/SkillTabContainer/SpecializedSkill
@onready var skill_1 = $SkillsContainer/VBoxContainer/skills1/skill1
@onready var skill_2 = $SkillsContainer/VBoxContainer/skills1/skill2
@onready var skill_3 = $"SkillsContainer/VBoxContainer/extra info2/skill3"
@onready var skill_4 = $"SkillsContainer/VBoxContainer/extra info2/skill4"
@onready var p_dmg_calc = $"Damage Calcs/DMGInfo/DMGCalc/PDMGCalc/Calc"
@onready var m_dmg_calc = $"Damage Calcs/DMGInfo/DMGCalc/MDMGCalc/Calc"
@onready var s_dmg_calc = $"Damage Calcs/DMGInfo/DMGCalc/SDMGCalc/Calc"
@onready var c_dmg_calc = $"Damage Calcs/DMGInfo/DMGCalc/CDMGCalc/Calc"
@onready var health = $"Damage Calcs/DMGInfo/DMGCalc/HealthCalc/Health"
@onready var resource = $"Damage Calcs/DMGInfo/DMGCalc/ResourceCalc/Resource"
@onready var stats = $StatsContainer/VBoxContainer/Stats
@onready var points_left = $StatsContainer/VBoxContainer/Stat_L/Total
@onready var strg = $StatsContainer/VBoxContainer/Stats/Strength/Point
@onready var intel = $StatsContainer/VBoxContainer/Stats/Intelligence/Point
@onready var dex = $StatsContainer/VBoxContainer/Stats/Dexterity/Point
@onready var con = $StatsContainer/VBoxContainer/Stats/Control/Point
@onready var spd = $StatsContainer/VBoxContainer/Stats/Speed/Point
@onready var coord = $StatsContainer/VBoxContainer/Stats/Coordination/Point
@onready var bio = $Bio
@onready var ch_name = $Picture/VBoxContainer/Picture_I/Name
#Confirmation popup variables
@onready var popup = $ConfirmationDialog
@onready var name_in = $ConfirmationDialog/Card/VBoxContainer/HBoxContainer/name_in
@onready var r_img_in = $ConfirmationDialog/Card/VBoxContainer/race_img
@onready var c_img_in = $ConfirmationDialog/Card/VBoxContainer/race_img/class_img
@onready var strg_in = $ConfirmationDialog/Card/VBoxContainer/race_img/class_img/VBoxContainer/HBoxContainer/strg_in
@onready var dex_in = $ConfirmationDialog/Card/VBoxContainer/race_img/class_img/VBoxContainer/HBoxContainer2/dex_in
@onready var intel_in = $ConfirmationDialog/Card/VBoxContainer/race_img/class_img/VBoxContainer/HBoxContainer3/intel_in
@onready var con_in = $ConfirmationDialog/Card/VBoxContainer/race_img/class_img/VBoxContainer/HBoxContainer4/con_in
@onready var spd_in = $ConfirmationDialog/Card/VBoxContainer/race_img/class_img/VBoxContainer/HBoxContainer5/spd_in
@onready var coord_in = $ConfirmationDialog/Card/VBoxContainer/race_img/class_img/VBoxContainer/HBoxContainer6/coord_in
@onready var skill1_in = $ConfirmationDialog/Card/VBoxContainer/SKills_ins/skill_in1
@onready var skill2_in = $ConfirmationDialog/Card/VBoxContainer/SKills_ins/skill_in2
@onready var skill3_in = $ConfirmationDialog/Card/VBoxContainer/SKills_ins/skill_in3
@onready var skill4_in = $ConfirmationDialog/Card/VBoxContainer/SKills_ins/skill_in4
@onready var health_in = $ConfirmationDialog/Card/VBoxContainer/bars/health
@onready var resc_in = $ConfirmationDialog/Card/VBoxContainer/bars/resc




var s_1
var s_2
var s_3
var s_4
var test


var max_points = 33

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	popup.set_visible(false)
	change_stats()
	pick_option(race_option)
	pick_option(class_option)
	points_left.text = str(max_points)
	
	
func pick_option(option):
	if option == race_option:
		for race in global.races:
			option.add_item(race.rc_name)
	if option == class_option:
		for clas in global.classes:
			option.add_item(clas.c_name)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func clear_all_skills():
	keep_first_child(r_skill_option )
	keep_first_child(c_skill_option )
	keep_first_child(u_skill_option )
	keep_first_child(sp_skill_option)
func keep_first_child(container):
	var temp = container.get_child(0)
	container.remove_child(temp)
	clear_container_children(container)
	container.add_child(temp)
func clear_container_children(container: Node) -> void:
	if container and container.get_child_count() > 0:
		skill_1.text = ""
		skill_2.text = ""
		skill_3.text = ""
		skill_4.text = ""
		
		for child in container.get_children():
			container.remove_child(child)
			child.queue_free()
func _on_class_item_selected(index) :
	clear_all_skills()
	var temp = get_entry()
	var race = temp[0]
	var clas = temp[1]
	skill_check(race,clas)
func _on_race_item_selected(index) :
	clear_all_skills()
	var temp = get_entry()
	var race = temp[0]
	var clas = temp[1]
	skill_check(race,clas)
func get_entry():
	var c_index = class_option.get_selected()
	var r_index = race_option.get_selected()
	var race = race_option.get_item_text(r_index)
	var clas = class_option.get_item_text(c_index)
	return [race,clas]
func skill_check(race,clas):
	for skill in global.skills:
		
		if clas == skill.s_class && skill.s_race == "":
			skill_entry(c_skill_option,skill.s_name,str(skill.s_dmg), skill.s_dmg_type, str(skill.s_resource_cost), str(skill.s_num_hits))
		if race == skill.s_race && skill.s_class == "":
			skill_entry(r_skill_option,skill.s_name,str(skill.s_dmg), skill.s_dmg_type, str(skill.s_resource_cost), str(skill.s_num_hits))
		if race == skill.s_race && clas == skill.s_class:
			skill_entry(sp_skill_option,skill.s_name,str(skill.s_dmg), skill.s_dmg_type, str(skill.s_resource_cost), str(skill.s_num_hits))
		if skill.s_race == "" && skill.s_class == "":
			skill_entry(u_skill_option,skill.s_name,str(skill.s_dmg), skill.s_dmg_type, str(skill.s_resource_cost), str(skill.s_num_hits))
		for c in global.classes:
			if c.c_name == clas:
				for r in global.races:
					if r.rc_name == race:
						choose_skills(skill,c,r)
func skill_entry(s_container,at1,at2,at3,at4,at5):
	var entry =    HBoxContainer.new()
	var add_butt = CheckButton.new()
	var attributes = [at1,at2,at3,at4,at5]
	s_container.add_child(entry)
	entry.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	for attribute in attributes:
		var label = Label.new()
		label.text = attribute
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		entry.add_child(label)
	entry.add_child(add_butt)
func choose_skills(skill,clas,race):
	for tab in skill_container.get_children():
		for hbox in tab.get_children():
			for item in hbox.get_children():
				if item is CheckButton:
					item.toggled.connect(check_button_toggled.bind(hbox,skill,clas,race))
					
	


func check_button_toggled(this,hbox,skill,clas,race):
	dmg_calc(skill,clas,race)
	
	var s_name = skill.s_name
	if this == true && skill_1.text == "":
		skill_1.set_text(s_name)
		s_1 = skill
	elif this == true && skill_2.text == "":
		skill_2.set_text(s_name)
		s_2 = skill
	elif this == true && skill_3.text == "":
		skill_3.set_text(s_name)
		s_3 = skill
	elif this == true && skill_4.text == "":
		skill_4.set_text(s_name)
		s_4 = skill
	elif this == true:
		print("Only 4 skills can be selected")
	if this == false && skill_1.text == s_name:
		skill_1.set_text("")
		s_1 = null
	elif this == false && skill_2.text == s_name:
		skill_2.set_text("")
		s_2 = null
	elif this == false && skill_3.text == s_name:
		skill_3.set_text("")
		s_3 = null
	elif this == false && skill_4.text == s_name:
		skill_4.set_text("")
		s_4 = null
	



func dmg_calc (skill,clas,race):
	var type = skill.s_dmg_type
	var h_calc = str(int(race.rc_health) * float(clas.c_health_mod))
	var r_calc = str(int(race.rc_resc) * float(clas.c_resc_mod))
	var dmg = str(skill.s_dmg)
	var cost = skill.s_resource_cost
	var num_hits = skill.s_num_hits
	var s_stat = int(strg.text)
	var i_stat = int(intel.text)
	var d_stat = int(dex.text)
	var c_stat = int(con.text)
	var sp_stat = int(spd.text)
	var co_stat = int(coord.text)
	var tot_dmg = skill.s_dmg * skill.s_num_hits
	resource.set_text(r_calc)
	health.set_text(h_calc)
	
	if type == "Magical":
		p_dmg_calc.set_text("")
		s_dmg_calc.set_text("")
		m_dmg_calc.set_text(str(tot_dmg * i_stat))
	elif type == "Physical":
		m_dmg_calc.set_text("")
		s_dmg_calc.set_text("")
		p_dmg_calc.set_text(str(tot_dmg * s_stat))
	elif type == "Skillful":
		p_dmg_calc.set_text("")
		m_dmg_calc.set_text("")
		s_dmg_calc.set_text(str(tot_dmg * d_stat))
	elif  type == "All":
		p_dmg_calc.set_text(dmg)
		m_dmg_calc.set_text(dmg)
		s_dmg_calc.set_text(dmg)
		
		
	

	


func change_stats ():
	for stat in stats.get_children():
		for item in stat.get_children():
			var items = stat.get_children()
			if item.get_text() == "+":
				item.pressed.connect(_on_more_pressed.bind(items))
			if item.get_text() == "-":
				item.pressed.connect(_on_less_pressed.bind(items))
				
				

func _on_more_pressed(items):
	var point = int(items[2].text)
	var avail = int(points_left.text)
	if avail > 0 and point < 10:
		point += 1
		avail -= 1
		items[2].text = str(point)
		points_left.text = str(avail)
			
func _on_less_pressed(items):
	var point = int(items[2].text)
	var avail = int(points_left.text)
	
	if avail < max_points and point > 1:
		point -= 1
		avail += 1
		items[2].text = str(point)
		points_left.text = str(avail)
	pass





func _on_create_pressed() -> void:

	
	if points_left.text != "0":
		print("There are still Stat Points left!!")
		
	var prompt = """Create an imeage of a Dungeons and Dragons inspired character
	and use the provided information to influence the image:
	
	Name: %s
	Class: %s
	Race: %s
	
	The next section is the stats section. the minimum stat number is 1 and the maximum stat number is 10. 
	the stats represent the characters abilities for examaple 1 strength is is the 
	character has the stregth of a newborn baby and 10 strength would be god-like strength.
	Stats:
	  Strength: %s
	  Dexterity: %s
	  Intelligence: %s
	  Speed: %s
	  Constitution: %s
	  Coordination: %s
	
	Skills:
	  1) %s
	  2) %s
	  3) %s
	  4) %s
	
	Image Requirements for all images:
	  • Must be Humanoid
	  • All accessories should relate to the chosen Class
	  • Character image should resemble the chosen Race
	
	Art Style:
	  A flat, 2D illustration with a vibrant and minimalistic style.
	  Clean and bold lines define the characters and objects,
	  with a strong focus on simplified yet expressive details.
	  The color palette is rich and saturated, using complementary
	  and contrasting colors for visual impact. Shadows and highlights
	  are applied subtly, using soft gradients or solid shapes to
	  emphasize depth without over-complication. The design conveys
	  a polished, stylized look reminiscent of modern fantasy or
	  action game artwork. There should be no text in the picture unless 
	  it is on the character design itself. no outside to text to describe
	  the character. 
	""" % [
		ch_name.text, class_option.text, race_option.text,
		strg.text, dex.text, intel.text, spd.text, con.text, coord.text,
		skill_1.text, skill_2.text, skill_3.text, skill_4.text
	]

	
	var schema = {
	"type": "object",
	"properties": {
		"prompt": {
			"type": "string",
			"min_length": 1,
			"max_length": 2048,
			"description": prompt
		},
		"steps": {
			"type": "int",
			"default": 4,
			"max_value": 8,
			"description": "The number of diffusion steps; higher values can improve quality but take longer."
		}
	},
	"required": ["prompt"]
}
	

	popup.set_visible(true)



func _on_cancel_pressed() -> void:
	popup.set_visible(false)


func _on_confirm_pressed() -> void:
	Transition.transition_to_scene("res://Scenes/duty_roster.tscn")
	Recruit.new(ch_name,r_img,c_img,strg,dex,intel,con,spd,coord,s_1,s_2,s_3,s_4,health,resource)
	
