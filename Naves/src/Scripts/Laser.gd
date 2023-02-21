extends Area

var speed = 1500
var damage = 50

var parentName : String
var canShoot: bool

onready var danio = get_node("../../Escenas/Antiaereo.tscn")
onready var explosivo = get_node("../../Escenas/explosivo.tscn")
onready var container = get_node("../../Escenas/objetivo.tscn")
var timer

# Called when the node enters the scene tree for the first time.
func _physics_process(delta) -> void:
	var direccion_adelante = global_transform.basis.z.normalized()
	global_translate(-direccion_adelante * speed * delta)

func _on_Laser_area_entered(area: Area) -> void:
	if area.has_method("take_damage") and area.name !=parentName:
		destroy()
	if area.has_method("reci") and area.name !=parentName:
		destroy()

func _on_Laser_body_entered(body: Node) -> void:
	if body.has_method("take_damage") and body.name !=parentName:
		danio.take_damage(damage)
		destroy()
	
	if body.has_method("reci") and body.name !=parentName:
		explosivo.reci(damage)
		destroy()

func destroy():
	queue_free()

func _on_DestroyTimer_timeout():
	destroy()
	pass # Replace with function body.
