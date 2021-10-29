extends Area2D

var id

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const Shot = preload("res://Shot.tscn")
export var thrust = 100
export var speed = Vector2(0, 20)
export var turn_ratio = 200
signal shoot
# Called when the node enters the scene tree for the first time.
func _ready():
	if id == 1:
		$Sprite.modulate = Color(0, 0.6, 0, 1)
	if id == 2:
		$Sprite.modulate = Color(0.6, 0, 0, 1)
	pass # Replace with function body.



func _process(delta):
	if id == 1:
		if Input.is_action_pressed("Player1_right"):
			rotation_degrees += turn_ratio * delta
		if Input.is_action_pressed("Player1_left"):
			rotation_degrees -= turn_ratio * delta
		if Input.is_action_pressed("Player1_thrust"):
			speed = speed + Vector2(thrust, 0).rotated(deg2rad(rotation_degrees)) * delta
		if Input.is_action_pressed("Player1_shoot"):
			if $Timer.one_shot:
				shoot()
				$Timer.one_shot = false
		if Input.is_action_just_released("Player1_shoot"):
			$Timer.one_shot = true
	if id == 2:
		if Input.is_action_pressed("Player2_right"):
			rotation_degrees += turn_ratio * delta
		if Input.is_action_pressed("Player2_left"):
			rotation_degrees -= turn_ratio * delta
		if Input.is_action_pressed("Player2_thrust"):
			speed = speed + Vector2(thrust, 0).rotated(deg2rad(rotation_degrees)) * delta
		if Input.is_action_pressed("Player2_shoot"):
			if $Timer.one_shot:
				shoot()
				$Timer.one_shot = false
		if Input.is_action_just_released("Player2_shoot"):
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


func _on_Ship_area_entered(area):
	if "Shot" in area.name:
		if id == 1:
			Global.score_player2 += 1
		else:
			Global.score_player1 += 1
	pass # Replace with function body.
