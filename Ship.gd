extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const Shot = preload("res://Shot.tscn")
export var thrust = 200
export var speed = Vector2(0, 20)
export var turn_ratio = 200
signal shoot
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed("ui_right"):
		rotation_degrees += turn_ratio * delta
	if Input.is_action_pressed("ui_left"):
		rotation_degrees -= turn_ratio * delta
	if Input.is_action_pressed("ui_down"):
		speed = speed + Vector2(thrust, 0).rotated(deg2rad(rotation_degrees)) * delta
	if Input.is_action_pressed("ui_up"):
		if $Timer.one_shot:
			shoot()
			$Timer.one_shot = false
	if Input.is_action_just_released("ui_up"):
		$Timer.one_shot = true
		
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

func shoot():
	emit_signal("shoot")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
