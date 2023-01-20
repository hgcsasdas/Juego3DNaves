extends CollisionShape

var speed : float = 320.0
var damage: int = 25


func _process(delta: float) -> void:
	translation += global_transform.basis.z * speed * delta

func _on_Area_body_entered(body: Node) -> void:
	
	if body.has_method("take_damage"):
		body.take_damage(damage)
		destroy()
	pass # Replace with function body.
	
	
func destroy():
	queue_free()


func _on_Timer_timeout():
	destroy()
	pass # Replace with function body.
