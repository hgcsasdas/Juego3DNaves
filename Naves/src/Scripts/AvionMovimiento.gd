extends Camera


#########################
# EXPORT PARAMS
#########################
# speed
var velocidad = 50
var turbo = 0
# guiñada ~ guiniada (yaw) girar en eje y
var guiniada_vel = 10
var max_guiniada = 70
# girar (roll) poner el avión de lado
var max_giro = 70.0
var giro = 1
var giro_vel = 10
# inclinar (pitch) inclinación o declinación de los aviones
var max_inclinacion = 30

var tiempo_turbo = 5

var gravedad = -9.81

onready var model = $Plane
onready var laserScene = preload("res://Laser.tscn")
onready var pivote = get_node("Position3D")

func _process(delta: float) -> void:
	_move(delta, turbo)
	arriba(delta)
	abajo(delta)
	girarIzq(delta)
	girarDer(delta)
	rotarDer(delta)
	rotarIzq(delta)
	turbo()
	
#	_pitch(delta)
#	_yaw(delta)

	if Input.is_action_pressed("shoot"):
		print("asd")
		disparar()

func disparar():
	"""fallo?"""
	print("af")
	var laser = laserScene.instance()
	var sceneLaser = get_tree().root.get_children()[0]
	sceneLaser.call_deferred("add_child", laser)
	laser.parentName = self.name
	laser.global_transform = pivote.global_transform
	#las.scale = Vector3.ONE
#########################
# MOVEMENT FUNCTIONS
#########################
func _move(delta: float, turbo: float) -> void:
	translation -= transform.basis.z * delta * velocidad * turbo

func arriba(delta: float) -> void:
	if Input.is_action_pressed("arriba"):
		rotation_degrees.x += delta * giro_vel + 0.75

func abajo(delta: float) -> void:
	if Input.is_action_pressed("abajo"):
		rotation_degrees.x -= delta * giro_vel + 0.75
		
func girarIzq(delta: float) -> void:
	if Input.is_action_pressed("girarIzq"):
		rotation_degrees.y += delta * giro_vel + 0.75

func girarDer(delta: float) -> void:
	if Input.is_action_pressed("girarDer"):
		rotation_degrees.y -= delta * giro_vel + 0.75
		
func rotarIzq(delta: float) -> void:
	if Input.is_action_pressed("virarIzq"):
		#model.set_rotation(Vector3(-90, -90,90))
		#if model.rotation_degrees.z < max_giro:
			model.rotate(Vector3(0, 0, 1), delta)
		
func rotarDer(delta: float) -> void:
	if Input.is_action_pressed("virarDer"):
		model.rotate(Vector3(0, 0, -1),delta)

func turbo() -> void:
	if Input.is_action_pressed("turbo"):
		turbo = 2.0
	else:
		turbo = 1
