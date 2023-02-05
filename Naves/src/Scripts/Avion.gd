extends KinematicBody

# Movement parameters
var velocity = 100 # speed of movement
var yaw_speed = 50 # speed of yaw rotation
var pitch_speed = 50 # speed of pitch rotation
var roll_speed = 8 # speed of roll rotation
var gravity = -9.81
var turbo = 1

# Instances
onready var model = get_node("Plane_modelo")
onready var laser_scene = preload("res://src/Escenas/laser.tscn")
onready var pivot = get_node("Plane_modelo/Position3D")

# Variables
var angulo_del_avion

# Functions executed every frame
func _process(delta: float) -> void:
	angulo_del_avion = global_rotation 
	print(angulo_del_avion)

	_move(delta)
	_yaw(delta)
	_pitch(delta)
	_roll(delta)
	shoot()

# Movement functions
func _move(delta: float) -> void:
	translation -= transform.basis.z * delta * velocity * turbo
	
func _yaw(delta: float) -> void:
	if Input.is_action_pressed("girarIzq"):
		if angulo_del_avion < Vector3(global_rotation.x,global_rotation.y,0.5):
			rotate(Vector3(0, 0, 1), delta * roll_speed * 45.0 / 180.0)
		else:
			rotation_degrees.y += delta * yaw_speed
	elif Input.is_action_pressed("girarDer"):
		if angulo_del_avion > Vector3(global_rotation.x,global_rotation.y,-0.5):
			rotate(Vector3(0, 0, -1), delta * roll_speed * 45.0 / 180.0)
		else:
			rotation_degrees.y -= delta * yaw_speed

func _pitch(delta: float) -> void:
	if Input.is_action_pressed("arriba"):
		rotation_degrees.x += delta * pitch_speed
	elif Input.is_action_pressed("abajo"):
		rotation_degrees.x -= delta * pitch_speed

func _roll(delta: float) -> void:
	if Input.is_action_pressed("virarIzq"):
		rotate(Vector3(0, 0, 1), delta * roll_speed)
	elif Input.is_action_pressed("virarDer"):
		rotate(Vector3(0, 0, -1), delta * roll_speed)

# Shoot function
func shoot():
	if Input.is_action_pressed("shoot"):
		var laser = laser_scene.instance()
		var scene_laser = get_tree().root.get_children()[0]
		scene_laser.call_deferred("add_child", laser)
		#laser.parent_name = self.name
		laser.global_transform = pivot.global_transform
		
#turbo func
func turbo():
	if Input.is_action_pressed("turbo"):
		turbo = 5
