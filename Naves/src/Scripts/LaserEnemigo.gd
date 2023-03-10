extends Area

var speed = 1600
var damage = 50
var parentName : String
var canShoot: bool

onready var danio = get_node("../Plane")

# Called when the node enters the scene tree for the first time.
func _physics_process(delta) -> void:
	var direccion_adelante = global_transform.basis.z.normalized()
	#var direccion_arriba = global_transform.basis.y.normalized()
	global_translate(-direccion_adelante * speed * delta )
	
func _on_LaserEnemigo_area_entered(area: Area) -> void:
	if area.has_method("take_damage") and area.name !=parentName:
		destroy()

func atacar():
	danio.take_damage(damage)


func destroy() -> void:
	queue_free()


func _on_LaserEnemigo_body_entered(body: Node) -> void:
	if body.has_method("take_damage") and body.name !=parentName:
		danio.take_damage(damage)
		destroy()


func _on_DestroyTimer_timeout():
	destroy()
	pass # Replace with function body.

