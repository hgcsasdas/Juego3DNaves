extends Node2D

var bar_red = preload("res://barHorizontal_red_mid 200.png")
var bar_yellow = preload("res://barHorizontal_yellow_mid 200.png")

onready var healthbar = $HealthBar

func _ready():
	hide()
	if get_parent() and get_parent().get("max_health"):
		healthbar.max_value = get_parent().max_health

func _process(delta):
	global_rotation = 0

func update_(vida):
	healthbar.texture_progress = bar_yellow
	if vida < healthbar.max_value * 0.35:
		healthbar.texture_progress = bar_red
	if vida < healthbar.max_value:
		show()
	healthbar.value = vida
