extends Spatial

onready var todo = get_node("../../objetivo")
onready var explosionAnimation = preload("res://src/Escenas/explosion.tscn")
onready var pivot = get_node("../../explosionContainer")
var timer
var vida = 1
var damage = 50

func _ready():
	pass

func reci(damage):
	vida -= damage
	if vida <= 0:
		todo.queue_free()
		var explosion = explosionAnimation.instance() 
		get_tree().get_root().call_deferred("add_child", explosion)
		explosion.global_transform = pivot.global_transform
		timer = Timer.new()
		timer.set_wait_time(3)
		timer.set_one_shot(true)
		timer.connect("timeout", self, "cambiar_escena")
		add_child(timer)
		timer.start()

func cambiar_escena():
	get_tree().change_scene("res://src/Menu/Menu.tscn")


func _on_Area_area_entered(area):
	reci(damage)

func _on_Area_body_entered(body):
	pass
