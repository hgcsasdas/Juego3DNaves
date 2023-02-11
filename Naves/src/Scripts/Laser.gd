extends Area

var speed = 500
var damage = 25
var parentName : String
var canShoot: bool

var timer

# Called when the node enters the scene tree for the first time.
func _physics_process(delta) -> void:
	var direccion_adelante = global_transform.basis.z.normalized()
	global_translate(-direccion_adelante * speed * delta)
	
func _on_Laser_area_entered(area: Area) -> void:
	if area.has_method("recibirdamage") and area.name !=parentName:
		area.recibirdamage(damage)
		destroy()

func _on_Laser_body_entered(body: Node) -> void:
	if body.has_method("recibirdamage") and body.name != parentName:
		body.recibirdamage(damage)
		destroy()

func destroy():
	queue_free()

func _on_DestroyTimer_timeout():
	destroy()
	pass # Replace with function body.
