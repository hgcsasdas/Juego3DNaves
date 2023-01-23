extends Area

onready var antiaereo = $Antiaircraft_gun
onready var raycast = $RayCast
onready var plane = get_node("../Avion/Kplayer/Position3D")
onready var laserScene = preload("res://src/Escenas/laserEnemigo.tscn")
onready var pivote = get_node("Antiaircraft_gun/Position3D")

var onRadius = false

func _process(delta):

	var playerPos = plane.global_transform.origin
	#print(playerPos)
	
	disparar()
	

	antiaereo.look_at(Vector3(playerPos.x, antiaereo.global_transform.origin.y, playerPos.z), Vector3.UP)
	#apuntarJugador(delta)
""""func verificarDistancia():
	print("sd")
	if """

	
func apuntarJugador(delta: float) -> void:
		antiaereo.rotation_degrees.y += delta * 100

func disparar():
	if onRadius:
		var laser = laserScene.instance()
		var sceneLaser = get_tree().root.get_children()[0]
		sceneLaser.call_deferred("add_child", laser)
		laser.parentName = self.name
		laser.global_transform = pivote.global_transform
		laser.global_transform = pivote.global_transform

		
func _on_Area_body_entered(body):
	onRadius = true
	print("entered")


func _on_Area_body_exited(body):
	print("exit")
	onRadius = false
