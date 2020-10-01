extends "res://PickableObjects/Object_pickable.gd"

onready var tip_mat := SpatialMaterial.new()
var size := 0.3

func action():
	if tip_mat.albedo_color == Color(1,1,1):
		tip_mat.albedo_color = Color(1,0,0)
		size = 0.3
	elif tip_mat.albedo_color == Color(1,0,0):
		tip_mat.albedo_color = Color(0,1,0)
	elif tip_mat.albedo_color == Color(0,1,0):
		tip_mat.albedo_color = Color(0,0,1)
	elif tip_mat.albedo_color == Color(0,0,1):
		tip_mat.albedo_color = Color(0,0,0)
	else:
		tip_mat.albedo_color = Color(1,1,1)
		size = 1.0

func _ready():
	tip_mat.albedo_color= Color(1,0,0)
	$PenTip.material_override = tip_mat

func _process(_delta):
	if $RayCast.is_colliding():
		var what_did_we_hit = $RayCast.get_collider()
		if what_did_we_hit.has_method("draw"):
			what_did_we_hit.draw($RayCast.get_collision_point(), tip_mat.albedo_color, size)

func pick_up(by,with_controller):
	.pick_up(by,with_controller)
	$RayCast.enabled = is_picked_up()
