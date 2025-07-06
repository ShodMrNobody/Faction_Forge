extends Control  # or the base node of your scene


@onready var roster = $ScrollContainer/HBoxContainer

var total_recruits = int(global.recruits.size())
var float_size = float(total_recruits) / 3
var float_string = str("%.1f" % float_size)





#remnant of inder system
func get_pages():
	var num_pages = 0.0
	var init_pages = float_string[0]
	var add_page = float_string[2]
	
	
	if int(add_page) > 0:
		num_pages = int(init_pages) + 1
	else:
		num_pages = int(init_pages)
	return num_pages


func _ready():
	global.load_roster()
	var num_pages = get_pages()
	add_char_to_page(roster)
	
#remanat of binder system
func add_page_to_roster(parent: Node, count: int) -> void:
	for i in range(count):
		var page = HBoxContainer.new()
		page.name = "VBox_%d" % i
		parent.add_child(page)
		
		page.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		page.size_flags_vertical = Control.SIZE_EXPAND_FILL
		
		
		
		add_char_to_page(roster)
	



func add_char_to_page(parent: Node):
	
	for i in global.recruits:
		var card = global.copy_node_from_other_tscn("res://Scenes/cards/character_card.tscn", "Option_3")
		parent.add_child(card)
		i.cur_resc = i.max_resc
		i.cur_health = i.max_health
		card.char_name.text = i.r_name
		#card.char_image = i.r_image
		card.strg.text = str(i.strg)
		card.dex.text = str(i.dex)
		card.intel.text = str(i.intel)
		card.ctr.text = str(i.ctr)
		card.spd.text = str(i.spd)
		card.crd.text = str(i.crd)
		card.abilities.add_item(i.skill1.s_name)
		card.abilities.add_item(i.skill2.s_name)
		card.abilities.add_item(i.skill3.s_name)
		card.abilities.add_item(i.skill4.s_name)
		card.health_bar.max_value = int(i.max_health)
		card.health_bar.value = int(i.cur_health)
		card.health_text.text = global.vert_string(i.cur_health +"/"+ i.max_health)
		card.resc_bar.max_value = int(i.max_resc)
		card.resc_bar.value = int(i.cur_resc)
		card.resc_text.text = global.vert_string(i.cur_resc +"/"+ i.max_resc)
		card.rank.text = i.rank
		card.wins.text = i.wins
		card.losses.text = i.losses
		card.race.text = i.race.rc_name
		card.clas.text = i.clas.c_name
		
		
		card.size_flags_horizontal = SIZE_EXPAND_FILL
		card.size_flags_vertical = SIZE_EXPAND_FILL
		
		

func _on_back_pressed() -> void:
		Transition.transition_to_scene("res://Scenes/main_menu.tscn")
