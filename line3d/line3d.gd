extends Node3D

func append(point):
	var sphere_point = $CSGSphere3D.duplicate()
	sphere_point.global_position = point
	sphere_point.visible = true
	add_child(sphere_point)
