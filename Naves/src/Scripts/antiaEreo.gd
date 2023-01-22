extends Area

onready var antiaereo = $Antiaircraft_gun
onready var raycast = $RayCast
onready var plane = get_node("../Avion/Kplayer/Plane_modelo")

var onRadius = false

func _process(delta):

	var playerPos = plane.global_transform.origin
	print(playerPos)
	
	#disparar()
	

	antiaereo.look_at(Vector3(playerPos.x, global_transform.origin.y, playerPos.z), Vector3.UP)
	#apuntarJugador(delta)
""""func verificarDistancia():
	print("sd")
	if """

	
func apuntarJugador(delta: float) -> void:
		antiaereo.rotation_degrees.y += delta * 100
"""""	
func disparar():
	if onRadius:
		print("pitopito")
	else: 
		print("")"""
		
func _on_Area_body_entered(body):
	onRadius = true
	print("entered")


func _on_Area_body_exited(body):
	print("exit")
	onRadius = false
