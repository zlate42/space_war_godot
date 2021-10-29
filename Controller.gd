extends Node
var Player = []


export var GRAV_CONST = 500000.0
const Ship = preload("res://Ship.tscn")
const Planet = preload("res://Planet.tscn")
const Shot = preload("res://Shot.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.projectResolution = get_viewport().get_visible_rect().size
	Global.score_player1 = 0
	Global.score_player2 = 0
	#	add Player 1
	Player.append(Ship.instance())
	Player[0].connect("shoot", self, "ship_shoot", [0])
	Player[0].id = 1
	Player[0].position = Vector2(Global.projectResolution.x/2 - 300, Global.projectResolution.y/2)
	Player[0].speed = Vector2(0, 50)
	add_child(Player[0])
	#	add Player 2
	Player.append(Ship.instance())
	Player[1].connect("shoot", self, "ship_shoot", [1])
	Player[1].id = 2
	Player[1].position = Vector2(Global.projectResolution.x/2 + 300, Global.projectResolution.y/2)
	Player[1].speed = Vector2(0, -50)
	add_child(Player[1])
	
	var Planet01 = Planet.instance()
	add_child(Planet01)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Score_player1.text = "P1: " + String(Global.score_player1)
	$Score_player2.text = "P2: " + String(Global.score_player2)
	pass

func ship_shoot(id):
	var shot = Shot.instance()
	add_child(shot)
	var muzzle = Player[id].get_node('Muzzle')
	shot.transform = muzzle.global_transform
	shot.speed = Player[id].speed + shot.speed.rotated(deg2rad(Player[id].rotation_degrees))

