extends Resource

class_name Race
var rc_name:String
var rc_strg: float
var rc_dex: float
var rc_intel:float
var rc_con:float
var rc_spd:float
var rc_cord:float
var rc_health:int
var rc_resc:int
var rc_skills:Array

func _init(name = "",strg = .00,dex = .00,intel = .00,con = 0.0, spd = .00,cord = .00,health = .00,resc = .00,skills = []):
	self.rc_name        =name
	self.rc_strg        =strg
	self.rc_dex         =dex
	self.rc_intel       =intel
	self.rc_con         =con
	self.rc_spd         =spd
	self.rc_cord        =cord
	self.rc_health      =health
	self.rc_resc        =resc
	self.rc_skills      =skills
	global.races.append(self)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
