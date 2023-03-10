extends Sprite3D

onready var bar = $Viewport/Node2D

func _ready():
	texture = $Viewport.get_texture()
	
func update_(vida):
	bar.update_bar(vida)
