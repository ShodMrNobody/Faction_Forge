extends Resource

class_name Team

var t_name: String = ""
var members: Array = []


func _init(name = "Home" , tm_1 = "" ,tm_2 = "" ,tm_3 = "" ,tm_4 = "" , tm_5 = "" , tm_6 = "", team = ""):
	if team == "team_1":
		global.team_1.clear()
		self.t_name = name
		self.members = [tm_1, tm_2, tm_3, tm_4, tm_5, tm_6]
		for mem in members:
			if mem != "":
				global.team_1.append(mem)
			
	elif team == "team_2":
		global.team_2.clear()
		self.t_name = name
		self.members = [tm_1, tm_2, tm_3, tm_4, tm_5, tm_6]
		for mem in members:
			if mem != "":
				global.team_2.append(mem)
