extends Area

onready var antiaereo = $Antiaircraft_gun
onready var raycast = $RayCast
onready var plane = get_node("../Plane/Plane_modelo/PosicionP")
onready var laserScene = preload("res://src/Escenas/laserEnemigo.tscn")
onready var pivote = get_node("Antiaircraft_gun/Position3D")
onready var pivote2 = get_node("Antiaircraft_gun/Position3D2")
onready var pivote3 = get_node("Antiaircraft_gun/Position3D3")
onready var pivote4 = get_node("Antiaircraft_gun/Position3D4")

var onRadius = false

var canShoot = true
var canShoot2 = true
var canShoot3 = true
var canShoot4 = true

export var cooldown =  0.5
export var cooldown2 =  0.5
export var cooldown3 =  0.5
export var cooldown4 =  0.5

var timer
var timer2
var timer3
var timer4
var timerEntre

func _ready():
	timer = Timer.new()
	timer2 = Timer.new()
	timer3 = Timer.new()
	timer4 = Timer.new()
	
	timerEntre = Timer.new()
	
	add_child(timer)
	timer.set_one_shot(true)
	timer.set_wait_time(cooldown)
	timer.connect("timeout", self, "_cooldownfin")
	
	add_child(timer2)
	timer2.set_one_shot(true)
	timer2.set_wait_time(cooldown)
	timer2.connect("timeout", self, "_cooldownfin2")
	
	add_child(timer3)
	timer3.set_one_shot(true)
	timer3.set_wait_time(cooldown)
	timer3.connect("timeout", self, "_cooldownfin3")
	
	add_child(timer4)
	timer4.set_one_shot(true)
	timer4.set_wait_time(cooldown)
	timer4.connect("timeout", self, "_cooldownfin4")

func _process(delta):
	var playerPos = plane.global_transform.origin
	#print(playerPos)
	
	
	antiaereo.look_at(Vector3(playerPos.x, antiaereo.global_transform.origin.y, playerPos.z -90 ), Vector3.UP)
	
	pivote.look_at(Vector3(playerPos.x + 2, playerPos.y + 2, playerPos.z), Vector3.UP)
	pivote2.look_at(Vector3(playerPos.x + 2, playerPos.y + 2, playerPos.z), Vector3.UP)
	pivote3.look_at(Vector3(playerPos.x + 2, playerPos.y + 2, playerPos.z), Vector3.UP)
	pivote4.look_at(Vector3(playerPos.x + 2, playerPos.y + 2, playerPos.z), Vector3.UP)
	dispararTODO()
	#apuntarJugador(delta)
""""func verificarDistancia():
	print("sd")
	if """


func apuntarJugador(delta: float) -> void:
		antiaereo.rotation_degrees.y += delta * 100

func dispararTODO():
	disparar()
	yield(get_tree().create_timer(1), "timeout")
	disparar2()
	yield(get_tree().create_timer(1), "timeout")
	disparar3()
	yield(get_tree().create_timer(1), "timeout")
	disparar4()
	yield(get_tree().create_timer(1), "timeout")

func disparar():
	if onRadius && canShoot:
		var laser = laserScene.instance()
		var sceneLaser = get_tree().root.get_children()[0]
		sceneLaser.call_deferred("add_child", laser)
		laser.parentName = self.name
		laser.global_transform = pivote.global_transform
		laser.global_transform = pivote.global_transform
		canShoot = false
		timer.start()
		print("1")

func disparar2():
	if onRadius && canShoot2:
		var laser = laserScene.instance()
		var sceneLaser = get_tree().root.get_children()[0]
		sceneLaser.call_deferred("add_child", laser)
		laser.parentName = self.name
		laser.global_transform = pivote2.global_transform
		laser.global_transform = pivote2.global_transform
		canShoot2 = false
		timer2.start()
		print("2")

func disparar3():
	if onRadius && canShoot3:
		var laser = laserScene.instance()
		var sceneLaser = get_tree().root.get_children()[0]
		sceneLaser.call_deferred("add_child", laser)
		laser.parentName = self.name
		laser.global_transform = pivote3.global_transform
		laser.global_transform = pivote3.global_transform
		canShoot3 = false
		timer3.start()
		print("3")


func disparar4():
	if onRadius && canShoot4:
		var laser = laserScene.instance()
		var sceneLaser = get_tree().root.get_children()[0]
		sceneLaser.call_deferred("add_child", laser)
		laser.parentName = self.name
		laser.global_transform = pivote4.global_transform
		laser.global_transform = pivote4.global_transform
		canShoot4 = false
		timer4.start()
		print("4")

func _on_Area_body_entered(body):
	onRadius = true
	print("entered")

func _on_Area_body_exited(body):
	print("exit")
	onRadius = false

func _cooldownfin():
	canShoot = true

func _cooldownfin2():
	canShoot2 = true

func _cooldownfin3():
	canShoot3 = true

func _cooldownfin4():
	canShoot4 = true
