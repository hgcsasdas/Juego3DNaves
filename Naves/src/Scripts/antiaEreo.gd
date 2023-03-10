extends KinematicBody

#INTERACCIÓN
var velMov = 0

#MODELOS
onready var antiaereo = $Antiaircraft_gun
onready var plane = get_node("../../Plane/Plane_modelo/PosicionP")
onready var danio = get_node("../../Plane")
onready var laserScene = preload("res://src/Escenas/laserEnemigo.tscn")
onready var pivote = get_node("Antiaircraft_gun/Position3D")
onready var pivote2 = get_node("Antiaircraft_gun/Position3D2")
onready var pivote3 = get_node("Antiaircraft_gun/Position3D3")
onready var pivote4 = get_node("Antiaircraft_gun/Position3D4")


#DETECCIÓN ENEMIGA
var onRadius = false

#VARIABLES DE DISPARO
var canShoot = true
var canShoot2 = true
var canShoot3 = true
var canShoot4 = true

#COOLDOWN
export var cooldown =  0.5
export var cooldown2 =  0.5
export var cooldown3 =  0.5
export var cooldown4 =  0.5

#TIMER CAÑON
var timer
var timer2
var timer3
var timer4
var timerEntre

#VARIABLES DE DAÑO A ENEMIGOS Y VIDA
var vida = 600
var damage = 50

#SETTING TIMER
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
	
	antiaereo.look_at(Vector3(playerPos.x, antiaereo.global_transform.origin.y, playerPos.z ), Vector3.UP)
	
	pivote.look_at(Vector3(playerPos.x, playerPos.y, playerPos.z), Vector3.UP)
	pivote2.look_at(Vector3(playerPos.x + 1, playerPos.y + 1, playerPos.z-10), Vector3.UP)
	pivote3.look_at(Vector3(playerPos.x - 1, playerPos.y - 1, playerPos.z-8), Vector3.UP)
	pivote4.look_at(Vector3(playerPos.x + 1, playerPos.y - 1, playerPos.z-12), Vector3.UP)
	dispararTODO()
	

func apuntarJugador(delta: float) -> void:
		antiaereo.rotation_degrees.y += delta * 100
func dispararTODO():
	disparar()
	yield(get_tree().create_timer(0.75), "timeout")
	disparar2()
	yield(get_tree().create_timer(1), "timeout")
	disparar3()
	yield(get_tree().create_timer(1.25), "timeout")
	disparar4()
	yield(get_tree().create_timer(1.5), "timeout")
	
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

func _cooldownfin():
	canShoot = true
func _cooldownfin2():
	canShoot2 = true
func _cooldownfin3():
	canShoot3 = true
func _cooldownfin4():
	canShoot4 = true

func _on_AreaDeteccion_body_exited(body):
	onRadius = false


func _on_AreaDeteccion_body_entered(body):
	onRadius = true


func take_damage(damage):
	vida -= damage
	print("Vida del anti" + str(vida))
	if vida <= 0:
		queue_free()

func atacar():
	danio.take_damage(damage)
	vida -= damage
	print(vida)
	if vida<=0:
		morir()

func morir():
	queue_free()
