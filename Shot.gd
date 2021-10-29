extends Area2D

export var speed = Vector2(150, 0)

func _ready():
#	connect("screen_exited", self, "_on_VisibilityNotifier2D_screen_exited")
	pass
	
func _process(delta):
	# rotate self in direction of movement
	self.rotation_degrees = rad2deg(self.speed.angle())
	if position.x > Global.projectResolution.x or position.y > Global.projectResolution.y:
		self.queue_free()
	if position.x < 0 or position.y < 0:
		self.queue_free()
	update_forces(delta)
	
func get_force(pos1: Vector2, pos2: Vector2):
	var vector_12: Vector2 = pos2 - pos1
	var distance:float = vector_12.length()
	var force:float = Global.GRAV_CONST / (distance * distance)
	var force_vector:Vector2 = vector_12.normalized() * force
	return force_vector;
	
func update_forces(delta):
		var central_force = get_force(self.position,Global.planet_position);
		self.speed = self.speed + central_force * delta
		self.position = self.position + self.speed * delta


#func _on_VisibilityNotifier2D_screen_exited():
#	print("screen exit")
#	self.queue_free()



func _on_Shot_area_entered(area):

	self.queue_free()
	pass # Replace with function body.
