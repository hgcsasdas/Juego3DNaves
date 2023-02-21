extends Spatial

# Declare member variables here. Examples:
onready var todo = get_node("../../objetivo")

#VARIABLE DE VIDA
var vida = 1
var damage = 50


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reci(damage):
	vida -= damage
	if vida <= 0:
		explotar()

func _on_Area_area_entered(area):
	pass # Replace with function body.


func _on_Area_body_entered(body):
	reci(damage)
	pass # Replace with function body.

func explotar():
	todo.queue_free()
