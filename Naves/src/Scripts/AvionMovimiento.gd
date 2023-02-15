extends KinematicBody
# Can't fly below this speed
var min_flight_speed = 0
# Maximum airspeed
var max_flight_speed = 300
# Turn rate
var turn_speed = 0.30
# Climb/dive rate
var pitch_speed = 0.5
# Wings "autolevel" speed
var level_speed = 3.0
# Throttle change speed
var throttle_delta = 30
# Acceleration/deceleration
var acceleration = 100.0
# Current speed
var forward_speed = 30
# Throttle input speed
var target_speed = 30
# Lets us change behavior when grounded
var grounded = false
var velocity = Vector3.ZERO
var turn_input = 0
var pitch_input = 0


# cooldown de disparo
var canShoot = true
var canShoot2 = true
export var cooldown =  0.25
export var cooldown2 =  0.25
var timer
var timer2
var vida = 500
var damage = 50


onready var model = get_node("Plane_modelo")
onready var laser_scene = preload("res://src/Escenas/laser.tscn")
onready var pivot1 = get_node("Plane_modelo/Position3D")
onready var pivot2 = get_node("Plane_modelo/Position3D2")
#hay que hacer que sea la escena, no el modelo
#onready var torreta = get_node("../Antiaereo")
onready var torreta = preload("res://src/Escenas/Antiaereo.tscn")

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.set_one_shot(true)
	timer.set_wait_time(cooldown)
	timer.connect("timeout", self, "_cooldownfin")
	
	timer2 = Timer.new()
	add_child(timer2)
	timer2.set_one_shot(true)
	timer2.set_wait_time(cooldown2)
	timer2.connect("timeout", self, "_cooldownfin2")

func get_input(delta):
	# Throttle input
	if Input.is_action_pressed("acelerar"):
		target_speed = min(forward_speed + throttle_delta * delta, max_flight_speed)
	if Input.is_action_pressed("decelerar"):
		target_speed = max(forward_speed - throttle_delta * delta, min_flight_speed)
	turn_input = 0
	if Input.is_action_pressed("girarIzq"):
		turn_input += 5
	if Input.is_action_pressed("girarDer"):
		turn_input -= 5
	# Turn (roll/yaw) input

	"""turn_input -= Input.get_action_strength("")
	turn_input += Input.get_action_strength("")"""
	# Pitch (climb/dive) input
	pitch_input = 0
	pitch_input -= Input.get_action_strength("abajo")
	pitch_input += Input.get_action_strength("arriba")
	if Input.is_action_pressed("shoot"):
		shoot()
		shoot2()

func shoot():
	if (Input.is_action_pressed("shoot") && canShoot):
		var laser = laser_scene.instance()
		var scene_laser = get_tree().root.get_children()[0]
		scene_laser.call_deferred("add_child", laser)
		#laser.parent_name = self.name
		laser.global_transform = pivot2.global_transform
		
		canShoot = false
		timer.start()
	
func shoot2():
	if (Input.is_action_pressed("shoot") && canShoot2):
		var laser = laser_scene.instance()
		var scene_laser = get_tree().root.get_children()[0]
		scene_laser.call_deferred("add_child", laser)
		#laser.parent_name = self.name
		laser.global_transform = pivot1.global_transform
		
		canShoot2 = false
		timer2.start()
	
func _physics_process(delta):
	get_input(delta)
	# Accelerate/decelerate
	forward_speed = lerp(forward_speed, target_speed, acceleration * delta)
	transform.basis = transform.basis.rotated(transform.basis.x, pitch_input * pitch_speed * delta)
	transform.basis = transform.basis.rotated(Vector3.UP, turn_input * turn_speed * delta)
	model.rotation.z = lerp(model.rotation.y, turn_input, level_speed * delta)
	# Movement is always forward
	velocity = -transform.basis.z * forward_speed
	velocity = move_and_slide(velocity, Vector3.UP)
	#print(forward_speed)

func _cooldownfin():
	canShoot = true

func _cooldownfin2():
	canShoot2 = true

func take_damage(damageEnemigo):
	vida -= damageEnemigo
	print(vida)
	if vida<=0:
		queue_free()


func atacar():
	torreta.take_damage(damage)
	vida -= damage
	print(vida)
	if vida<=0:
		queue_free()
