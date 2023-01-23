extends Camera


#########################
# PARAMETROS MOVIMIENTO AVIÓN
#########################
# speed
var velocidad = 5
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

#Interacciones

var vida = 100

var gravedad = -9.81


#Instancias
onready var model = get_node("Kplayer/Plane_modelo")
onready var laserScene = preload("res://src/Escenas/laser.tscn")
onready var pivote = get_node("Kplayer/Position3D")

var angulo_del_avion
var angulo_del_pepe
#Acciones ejecutadas en cada fotograma
func _process(delta: float) -> void:
	
	angulo_del_avion = global_rotation 
	angulo_del_pepe = model.global_rotation 
	print(angulo_del_avion)
	
	_move(delta, turbo)
	arriba(delta)
	abajo(delta)
	girarIzq(delta)
	girarDer(delta)
	rotarDer(delta)
	rotarIzq(delta)
	turbo()
	disparar()


func disparar():
	if Input.is_action_pressed("shoot"):
		var laser = laserScene.instance()
		var sceneLaser = get_tree().root.get_children()[0]
		sceneLaser.call_deferred("add_child", laser)
		laser.parentName = self.name
		laser.global_transform = pivote.global_transform
	#las.scale = Vector3.ONE

#Funciones de movimiento
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
		#model.set_rotation(Vector3(-90, -90,90))
		if angulo_del_avion < Vector3(global_rotation.x,global_rotation.y,0.5):
			rotate_z(delta * 3)
		else:
			rotation_degrees.y += delta * giro_vel + 0.75

func girarDer(delta: float) -> void:
	if Input.is_action_pressed("girarDer"):
		if angulo_del_avion > Vector3(global_rotation.x,global_rotation.y,-0.5):
			rotate_z(delta * -3)
		else:
			rotation_degrees.y -= delta * giro_vel + 0.75

		
		
#Giros en tonel
func rotarIzq(delta: float) -> void:
	if Input.is_action_pressed("virarIzq"):
		rotate(Vector3(0, 0, 1), delta * 3)

func rotarDer(delta: float) -> void:
	if Input.is_action_pressed("virarDer"):
		rotate(Vector3(0, 0, -1), delta * 3)

func turbo() -> void:
	if Input.is_action_pressed("turbo"):
		turbo = 5.0
	else:
		turbo = 1


func _on_Area_body_entered():
	print("asdasdas")
