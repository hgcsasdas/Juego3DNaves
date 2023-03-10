extends Control



func _on_Jugar_pressed():
	get_tree().change_scene("res://src/Escenas/World.tscn")


func _on_Salir_pressed():
	get_tree().quit()


func _on_mapa2_pressed():
	get_tree().change_scene("res://src/Escenas/World2.tscn")
