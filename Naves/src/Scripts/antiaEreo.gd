extends Area

onready var antiaereo = $Antiaircraft_gun
onready var raycast = $RayCast
onready var plane = get_node("../Avion/Plane_modelo")


func _process(delta):
	#verificarDistancia()
	var playerPos = plane.global_transform.origin

	#antiaereo.look_at(Vector3(playerPos.x, global_transform.origin.y, playerPos.z), Vector3.UP)
	apuntarJugador(delta)
""""func verificarDistancia():
	print("sd")
	if """

	
func apuntarJugador(delta: float) -> void:
		antiaereo.rotation_degrees.y += delta * 100
		
func disparar():
	#asd
	print("hola")

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		print("entered")


func _on_Area_body_exited(body):
	print("exit")
	disparar()
