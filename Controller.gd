extends Node
var Ship01


export var GRAV_CONST = 500000.0
const Ship = preload("res://Ship.tscn")
const Planet = preload("res://Planet.tscn")
const Shot = preload("res://Shot.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.projectResolution = get_viewport().get_visible_rect().size
	Ship01 = Ship.instance()
	add_child(Ship01)
	Ship01.connect("shoot", self, "ship_shoot")
	var Planet01 = Planet.instance()
	add_child(Planet01)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func ship_shoot():
	var shot = Shot.instance()
	add_child(shot)
	var muzzle = Ship01.get_node('Muzzle')
	shot.transform = muzzle.global_transform
	shot.speed = Ship01.speed + shot.speed.rotated(deg2rad(Ship01.rotation_degrees))

