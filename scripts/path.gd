extends Node3D

@onready var main_node : Node3D = get_node("/root/Node3D")
@onready var main_head : Node3D = get_node("/root/Node3D/HeadNodeOrient")

var list = []

func add_point(posx: int, posy: int, posz: int):
	var dup = main_head.duplicate()
	dup.get_node("HeadNode").rotation_degrees.x = posx
	dup.get_node("HeadNode").rotation_degrees.y = posy
	dup.get_node("HeadNode").rotation_degrees.z = posz
	main_node.add_child(dup)
	#var loc : Vector3 = dup.get_node("HeadNode/Head").global_position
	list.append(dup)

func clear():
	for i in range(list.size()):
		main_node.remove_child(list.pop_back())
