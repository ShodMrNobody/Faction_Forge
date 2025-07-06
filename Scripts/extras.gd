extends Control

@onready var dex_icon = $dex_dmg
@onready var dex_label= $dex_dmg/Label
@onready var strg_icon = $strg_dmg
@onready var strg_label =$strg_dmg/Label
@onready var intel_icon =$intel_dmg
@onready var intel_label=$intel_dmg/Label
@onready var uni_icon =$universal_dmg
@onready var uni_label=  $universal_dmg/Label
@onready var crit_icon =$crit_dmg
@onready var crit_label= $crit_dmg/Label
@onready var f_s_d =$flat_stat_decrease
@onready var f_s_d_l =  $flat_stat_decrease/Label
@onready var f_s_i = $flat_stat_increase
@onready var f_s_i_l = $flat_stat_increase/Label
@onready var p_s_d = $percent_stat_decrease
@onready var p_s_d_l = $percent_stat_decrease/Label
@onready var p_s_i=  $flat_stat_increase
@onready var p_s_i_l = $percent_stat_increase/Label
@onready var heal  = $heal
@onready var heal_label= $heal/Label
@onready var r_r_s = $resource_removal_s
@onready var r_r_s_l  = $resource_removal_s/Label
@onready var r_r_m = $resource_removal_m
@onready var r_r_m_l  = $resource_removal_m/Label
@onready var r_g_s = $resource_gain_s
@onready var r_g_s_l  = $resource_gain_s/Label
@onready var r_g_m = $resource_gain_m
@onready var r_g_m_l  = $resource_gain_m/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
