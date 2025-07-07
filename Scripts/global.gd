extends Node

var classes = []
var races = []
var skills = []
var recruits = []
var effects = []
var card_layouts = []
var team_1 = []
var team_2 = []

func c_skill_sort(skill,array) :
	for clas in global.classes:
		if skill.s_class == clas.c_name:
			array.append(skill)
func r_skill_sort(skill,array) :
	for race in global.races:
		if skill.s_race == race.rc_name:
			array.append(skill)
func sp_skill_sort (skill,array):
	if c_skill_sort(skill,array) == r_skill_sort(skill,array):
		array.append(skill)
func u_skill_sort(skill,array):
	array.append(skill)
func sort_skills ():
	var array = []
	for skill in skills:
		if skill.s_class == "":
			r_skill_sort(skill,array)
		elif skill.s_race == "":
			c_skill_sort(skill,array)
		elif skill.s_class != "" && skill.s_race != "":
			sp_skill_sort(skill,array)
		elif skill.s_class == "" && skill.s_race == "":
			u_skill_sort (skill,array)
	
	return array


func copy_node_from_other_tscn(scene, node):
	var temp_scene = load(scene)
	var scene_copy = temp_scene.instantiate()
	var node_temp = scene_copy.get_node(node)
	var node_copy
	if node_temp == null:
		node_temp = scene_copy.get_child(0).get_node(node)
		if node_temp == null:
			node_temp = scene_copy.get_child(0).get_child(0).get_node(node)
	node_copy = node_temp.duplicate()
	
	return node_copy



#"Physical"= strg /"Skillful" = dex /"Magical" = intel /"Control" = con "All" = no mods but *3 dmg
#SP for stamina points MP for magical points
func _ready() -> void:
	
	
		#EFFECTS 
	var _enhance = Effect.new("Enhance","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"all":1},99,["struck"],1,"buff",false,{"Juice":1,"Infusion":2})
	var _juice = Effect.new("Juice", "res://Scenes/Icons/flat_stat_increase_icon.tscn",{"str":1,"dex":1,"intel":1},99,["on_hit"],1,"buff", false,{})
	var _wither = Effect.new("Wither","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"all":1},99,[],1,"debuff",true,{})
	var _infusion = Effect.new("Infusion","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"f_dmg":5},99,["on hit"],1,"dot",false,{})
	var _defusion = Effect.new("Defusion","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"f_dmg":5},99,["on hit"],1,"dot",true,{})
	var _flex = Effect.new("Flex","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"p_dmg":.05},99,[],1,"blast",false,{})
	var _flab = Effect.new("Flab","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"p_dmg":.05},99,[],1,"blast",true,{})
	var _guard = Effect.new("Guard","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"p_dmg_reduce":.10},99,[],1,"mark",false,{})
	var _halt = Effect.new("Halt","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"combo_gen":0},1,["struck"],1,"debuff",true,{})
	var _tremor = Effect.new("Tremor","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"combo_bonus":0},1,["struck"],1,"debuff",true,{})
	var _cheered = Effect.new("Cheered","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"combo_gen":.25},1,[],1,"buff",false,{})
	var _hype = Effect.new("Hype","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"combo_gen":.05},99,[],1,"buff",false,{})
	var _toxic = Effect.new("Toxic","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"hp_gen":0},2,[],1,"debuff",true,{})
	var _bleed = Effect.new("Bleed","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"hp_gen":.05},99,[],1,"debuff",true,{})
	var _sleep = Effect.new("Sleep","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"stun":1},99,["eor","struck"],2,"status",true,{})
	var _stun = Effect.new("Stun","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"stun":1},99,["eor"],1,"status",true,{"Weaken":2,"Blur":2})
	var _burn = Effect.new("Burn","res://Scenes/Icons/flat_stat_increase_icon.tscn",{},99,["eor","half"],1,"status",true,{"Bleed":1,"Expunge":1})
	var _poison = Effect.new("Poison","res://Scenes/Icons/flat_stat_increase_icon.tscn",{},99,["eor","half"],1,"status",true,{"Bleed":1,"Erase":1})
	var _shock = Effect.new("Shock","res://Scenes/Icons/flat_stat_increase_icon.tscn",{},99,["struck","max_stacks"],81,"status",true,{})
	var _chill = Effect.new("Chill","res://Scenes/Icons/flat_stat_increase_icon.tscn",{},5,["max_stacks"],1,"status",true,{"Slow":2})
	var _freeze = Effect.new("Freeze","res://Scenes/Icons/flat_stat_increase_icon.tscn", {"stun":1},1,["eor"],1,"status",true,{"Haze":2, "Klutz":2})
	var _shield = Effect.new("Shield","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"shield":.05},99,["depletion"],1,"buff",false,{})
	var _immune = Effect.new("Immune","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"effects":1},1,["eor"],1,"status",false,{})
	var _resist = Effect.new("Resist","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"effects":1},1,["eor"],1,"status",false,{})
	var _erase = Effect.new("Erase","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"hp":.01},99,[],1,"debuff",true,{})
	var _expunge = Effect.new("Expunge","res://Scenes/Icons/flat_stat_increase_icon.tscn",{"rp":.01},99,[],1,"debuff",true,{})
	#var _thorn = Effect.new("Thorn","res://Scenes/Icons/flat_stat_increase_icon.tscn","dmg",)
	
	
	
	#ADD NEW CLASSES HERE
	var _mage = char_class.new ("Mage",.95,1.15,1.30,1.15,1.15,1.20,1.05,1.30,global.sort_skills())
	var _dueslist = char_class.new ("Duelist",1.15,1.30,1.15,1.15,.90,1.20,1.10,1.15,global.sort_skills())
	var _berk = char_class.new ("Berserker",1.30,1.20,.90,1.10,1.20,1.15,1.25,1.15,global.sort_skills())
	var _herb = char_class.new("Herbalist",1.20,.90,1.15,1.30,1.10,1.10,1.20,1.30,global.sort_skills())
	var _sent = char_class.new("Sentinel",1.20,1.20,1.20,1.20,.90,1.0,1.30,1.05,global.sort_skills())
	
	
	#ADD NEW RACES HERE
	var _orc = Race.new("Orc",6,3,2,2,3,2,1750,90,global.sort_skills())
	var _elf = Race.new ("Elf",2,4,3,2,5,2,1500,100,global.sort_skills())
	var _human = Race.new("Human",2,3,3,3,2,5,1500,100,global.sort_skills())
	var _dwarf = Race.new("Dwarf",5,2,2,4,2,3,2200,110,global.sort_skills())
	var _goblin = Race.new("Goblin",2,5,2,2,2,5,1600,90,global.sort_skills())
	
	
	
	#ADD NEW SKILLS HERE
	#Class Skills ------------------------
	#------------BERSERKER SKILLS-------------------------
	var _crescentaxeswipe = Skill.new("Crescent Axe Swipe", "Berserker","","",45,.025,.1,6,10,"Physical","Hit Each Member on Target Team",{"Enhance":1})
	var _bah = Skill.new("B.A.H", "Berserker","","",35,0.0,-.15,1,50,"Physical","",{"Enhance":3, "Juice":2, "Sleep":1})
	var _ripandtear = Skill.new("Rip and Tear", "Berserker","","",30,0.05,.0,2,13,"Physical","Reduce Strength of Target By 20% Next Round.",{"Wither":1})
	var _dualmace = Skill.new("Dual Mace", "Berserker","","",40,0.1,-.1,2,20,"Physical","Reduce Speed of Target By 20% Next Round.",{"Juice":1})
	var _heavyslash = Skill.new("Heavy Slash", "Berserker","","",40,0.1,.1,1,40,"Physical","",{"Guard":1})
	var _twinslash = Skill.new("Twin Slash", "Berserker","","",40,0.05,.2,2,20,"Skillful","Apply 2 Stacks of Bleed. If Target if Bleeding, Deal +25% Damage.")
	var _hardfocus = Skill.new("Hard Focus", "Berserker","","",30,0.2,.0,1,0,"Control","Target Enemy Recieves +15% Damage From You. Last 2 Turns.")
	var _bathsalts = Skill.new("Bath Salts", "Berserker","","",20,0.0,.0,1,0,"Control","Increase Stats by 2 for 2 turns. Take 30% Max HP At End of Ability Charge Ability")
	
	
	#------------DUELIST SKILLS-------------------------
	var _crossslash = Skill.new("Cross Slash","Duelist","","",45,0.1,.3,2,20,"Skillful","")
	var _whirlwindstrike = Skill.new("Whirlwind Strike","Duelist","","",45,0.05,.1,4,10,"Skillful","Hit Each Member on Target Team")
	var _nitenichiryu = Skill.new("Niten Ichi-ryu","Duelist","","",35,0.05,.4,2,15,"Skillful","+15% Speed next Round.")
	var _practicedcut = Skill.new("Practiced Cut","Duelist","","",35,0.0,.0,1,50,"Skillful","")
	var _cosmiccrush = Skill.new("Cosmic Crush","Duelist","","",45,0.2,.1,1,45,"Physical","")
	var _chamleywatson = Skill.new("Chamley-Watson","Duelist","","",35,0.1,.8,1,25,"Magical","")
	var _limitbreak = Skill.new("Limit Break","Duelist","","",35,0.3,.0,1,0,"Control","Increase Speed And Dexterity by 2 for 3 Rounds. After Each Round Lose 5% Max HP.")
	var _retaliate = Skill.new("Retaliate","Duelist","","",20,0.0,.0,1,0,"Passive","If Combo is Above 200, When Attacked Use a Random Universal Damage Skill on the Attacker.")
	
	
	#RACE SKILLS -----------------------------------,""-
	#------------ORC SKILLS------------------------,""-
	var _backbreaker = Skill.new("Back Breaker", "","Orc", "",30,.2,-0.1,1,20, "Physical", "Slow Target by 10%", {"Enhance":1})
	var _throwhands = Skill.new("Throw Hands", "","Orc", "",30,.05,0.15,3,7, "Physical" ,"")
	var _useyourhead = Skill.new("Use Your Head", "","Orc", "",30,.05,-0.2,1,200, "Magical", "Half of damage dealt is inflicted on", )
	var _lowblow = Skill.new("Low Blow","","Orc","",20,.0,0.0,1,15,"Physical","Stun Targeted if Affected By A Slow. Last 1", )
	var _sternumkick = Skill.new("Sternum Kick","","Orc","",30,.1,0.05,1,25, "Physical" ,"")
	var _intimidate = Skill.new("Intimidate","","Orc","",0,.0,0.0,1,0,"Passive","When using a Strength Skill, reduce Targeted Strenght by 10% Until Your Next", )
	var _adrenaline = Skill.new("Adrenaline","","Orc","",35,.3,0.0,1,0,"Control","Reduce Total Health By 10% Until End of Battle; Restore 20 + 50% of Missing Resource;+4 Strenght Until End of Round;  -1 Intelligence Until Next", )
	var _warpaint = Skill.new("War Pain","","Orc","",20,.1,0.05,1,25,"Control","Raise all Stat Points by" ,)
	
	
	#------------ELF SKILLS------------------------,""-
	var _sweetchin = Skill.new("Sweet Chin", "","Elf", "",30,.1,0.05,1,20, "Physical", "Stun If Target Attacked An Ally This Turn")
	var _blitzkriege = Skill.new("Blitzkriege", "","Elf", "",25,.025,0.1,5,3, "Skillful", "")
	var _gloveslap = Skill.new("Glove Slap", "","Elf", "",35,.05,0.3,2,11, "Skillful", "Reduce Combo Generation of Target to 0 Until They Hit You")
	var _clanstrike = Skill.new("Clean Strike", "","Elf", "",25,.1,0.0,1,30, "Skillful", "")
	var _demean = Skill.new("Demean", "","Elf", "",30,.05,0.0,1,30, "Magical", "Stun Targeted if Affected By A Slow. Last 1 Turn ")
	var _dominate = Skill.new("Dominate", "","Elf", "",35,.02,0.0,1,25, "Magical", "Gain +10 Damage If Target is a Non-Elf")
	var _keenreflexes = Skill.new("Keen Reflexes", "","Elf", "",0,.0,0.0,1,0, "Passive", "Increase Speed and Dexterity by 1.")
	var _needlethroughwater = Skill.new("Needle Through Water", "","Elf", "",30,.2,0.0,1,0, "Control", "")
	
	
	#------------HUMAN SKILLS------------------------,""-
	var _streetfight = Skill.new("Street Fight", "","Human", "",30,.1,0.05,2,10, "Physical", "")
	var _getjumped = Skill.new("Get Jumped", "","Human", "",25,.05,0.0,3,7, "Physical", "*")
	var _throatchop = Skill.new("Throat Chop", "","Human", "",40,.3,0.1,1,15, "Skillful", "*")
	var _hiptoss = Skill.new("Hip Toss", "","Human", "",45,.2,0.1,1,40, "Skillful", "If Attacked by Selected Target, Stun them For 1 Turn.")
	var _disruptequilibrium = Skill.new("Disrupt Equilibrium", "","Human", "",30,.1,-0.2,1,30, "Magical", "Target Cannot Generate Combo Next Round")
	var _seekweakness = Skill.new("Seek Weakness", "","Human", "",35,.2,0.15,1,10, "Magical", "If you Attack the Same Target as Last Round, Deal +10 Damage")
	var _inspire = Skill.new("Inspire", "","Human", "",35,.3,0.0,1,0, "Control", "Increase The Combo Points your Team Generates. Last 2 Turns. ")
	var _tenacity = Skill.new("Tenacity", "","Human", "",0,.0,0.0,1,0, "Passive", "Increase Damage Reduction and Regenerate Resource by 5%.")
	
	
	#------------DWARF SKILLS------------------------,""-
	var _gutpunch = Skill.new("Gut Punch", "","Dwarf", "",30,.1,0.1,1,15, "Physical", "Reduce Targets Speed by 10% on their next Action.")
	var _heavyrock = Skill.new("Heavy Rock", "","Dwarf", "",30,.1,-0.3,1,40, "Physical", "")
	var _armadadupla = Skill.new("Armada Dupla", "","Dwarf", "",25,.1,0.1,1,25, "Skillful", "")
	var _spinninghookkick = Skill.new("Spinning Hook Kick", "","Dwarf", "",35,.3,-0.15,1,25, "Magical", "")
	var _flirting = Skill.new("Flirting", "","Dwarf", "",30,.1,0.15,1,15, "Magical", "Slow Target by 30% Until End of Next Round.")
	var _liquidcourage = Skill.new("Liquid Courage", "","Dwarf", "",25,.1,0.0,1,0, "Control", "Reduce Intelligence and Dexterity by 20%; Increase Strength and Damage Reduction by 20% Last 3 Turns. Can Stack.")
	var _sturdylegs = Skill.new("Sturdy Legs", "","Dwarf", "",20,.0,0.0,1,0, "Control", "Increase Damage Reduction by 50% on next hit.")
	var _madeofstone = Skill.new("Made of Stone", "","Dwarf", "",0,.0,0.0,1,0, "Passive", "Increase HP and Damage Reduction by 10%")
	
	
	#------------GOBLIN SKILLS------------------------,""-
	var _shinkick = Skill.new("Shin Kick", "","Goblin", "",25,.15,0.0,1,20, "Physical", "Slow Target by 10% Until End of Next Round.")
	var _wildstrikes = Skill.new("Wild Strikes", "","Goblin", "",35,.05,0.15,6,33, "Skillful", "")
	var _kidneypunch = Skill.new("Kidney Punch", "","Goblin", "",30,.1,0.1,2,10, "Skillful", "")
	var _tendonbite = Skill.new("Tendon Bite", "","Goblin", "",30,.2,0.0,1,25, "Skillful", "")
	var _poisonpie = Skill.new("Poison Pie", "","Goblin", "",35,.2,0.2,1,5, "Magical", "")
	var _callout = Skill.new("Call Out", "","Goblin", "",35,.3,0.0,1,0, "Control", "")
	var _backedin = Skill.new("Backed In", "","Goblin", "",0,.0,0.0,1,0, "Passive", "When Hp is Under 30% Increase Stat Points by 1")
	var _hide = Skill.new("Hide", "","Goblin", "",25,.1,0.0,1,0, "Control", "Reduce damage of next hit by 80%. Next hit after, Recieve an Additional 50% Damage.If you Attack out of hide, Deal 20% More Damage.")
	
	
	#-------------------------------------
	
	
	
	
	
	#UNIVERSAL SKILLS
	var _haymaker = Skill.new("Haymaker","","","",40,0.2,-0.1,1,45,"Universal","",{"Enhance":1})
	var _2piececombo = Skill.new("2 Piece Combo","","","",3,0.05,.2,2,20, "Universal", "",{"Infusion":1})
	var _sumoslam = Skill.new("Sumo Slam","","","",25,0.0,0.0,1,25,"Universal","Stun Target For 1 Turn Charge")
	var _bite = Skill.new("Bite","","","",40,0.1,-0.3,1,50,"Universal","Reduce Targeted Strength by 2 until next round")
	var _leonidas = Skill.new("Leonidas","","","",40,.2,0.2,1,35,"Universal","")
	var _quickjab = Skill.new("Quick Jab","","","",25,.05,0.6,1,15,"Universal","")
	var _stonethrow = Skill.new("Stone Throw","","","",30,.00,0.25,1,40,"Universal","")
	var _sidekick = Skill.new("Side Kick","","","",45,.2,0.1,1,35,"Universal","")
	var _flyingknee = Skill.new("Flying Knee","","","",35,.2,-0.05,1,40,"Universal","")
	var _eyegouge = Skill.new("Eye Gouge","","","",40,.05,-0.3,1,25,"Universal","Reduce target dexterity by 2 until end of next round")
	var _lukewarmice = Skill.new("Luke Warm Ice","","","",25,.1,-0.1,1,20,"Universal","reduce target speed by 10% for 1 round")
	var _standingfire = Skill.new("Standing Fire","","","",40,.5,0.0,2,13,"Universal","")
	var _staticshock = Skill.new("Static Shock","","","",25,.02,0.1,5,3,"Universal","")
	var _wittlepebble = Skill.new("Wittle Pebble","","","",25,.0,-0.5,1,35,"Universal","")
	var _summerbreeze = Skill.new("Summer Breeze","","","",30,.2,0.0,1,20,"Universal","")
	var _firstaid = Skill.new("First Aid","","","",30,.2,0.0,1,0,"Universal","Heal target by 15% of missing health")
	var _recovery = Skill.new("Recovery","","","",0,0,0.0,1,0,"Universal","Restore Resource by 1 + 30% of Missing Resource")
	var _raisespirits = Skill.new("Raise Spirits","","","",25,.1,0.0,1,0,"Universal","")
	var _provoke = Skill.new("Provoke","","","",25,.1,0.0,1,0,"Universal","Reduce Stats of Single Target By 1 Until Next Turn.")
	var _chintuck = Skill.new("Chin Tuck","","","",20,.0,0.0,1,0,"Universal","Reduce the Next Incoming Damage By 40% to Self. Last 1 Turn")
	
	
	
	
	
	
	#SPECIALIZED
	var _slash = Skill.new("Slash","Fighter","Human","SP",3,.5,.1,3,15, "Skillful", "Slash oooo scray")
	
	
	
var api_key 

func save_api_key():
	var api_key = "testtest"
	var file = FileAccess.open("user://api_key.data",FileAccess.WRITE)
	print(api_key)
	file.store_var(api_key)
	file.close()

func load_api():
	var file = FileAccess.open("user://api_key.data",FileAccess.READ)
	var key = file.get_var()
	print(key)
	file.close()
	
func save_roster():
	var file = FileAccess.open("user://roster.data",FileAccess.WRITE)
	file.store_var(recruits,true)
	file.close()
	
	
func load_roster():
	recruits.clear()
	var file = FileAccess.open("user://roster.data",FileAccess.READ)
	file.get_var(true)
	file.close()


func vert_string(tar_string):
	var vert_string = ""
	for letter in tar_string:
		vert_string += letter + "\n"
	return vert_string





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
