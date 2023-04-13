extends Node3D

@export var color: Color = Color.WHITE
@export var posx: float:
	set (value):
		self.rotation_degrees.x = value
@export var posy: float:
	set (value):
		self.rotation_degrees.y = value
@export var posz: float:
	set (value):
		self.rotation_degrees.z = value

func _ready():
	# make new material and assign color
	var material = StandardMaterial3D.new()
	material.albedo_color = color
	$CSGTorus3D.material = material
