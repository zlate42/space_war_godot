extends Area2D


func _ready():
	var projectResolution=get_viewport().get_visible_rect().size
	position = projectResolution/2
	pass # Replace with function body.

# warning-ignore:unused_argument
func _process(delta):
	Global.planet_position = position
	pass
	
func _draw():
	draw_circle(Vector2.ZERO, 50, Color.yellow)

