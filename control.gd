extends Control

@onready var HeadNode = get_node("/root/Node3D/HeadNodeOrient/HeadNode")

func _ready():
	# connect buttons
	($VBoxContainer/X/plus).pressed.connect(_button_pressed.bind("x+"))
	($VBoxContainer/X/minus).pressed.connect(_button_pressed.bind("x-"))
	($VBoxContainer/Y/plus).pressed.connect(_button_pressed.bind("y+"))
	($VBoxContainer/Y/minus).pressed.connect(_button_pressed.bind("y-"))
	($VBoxContainer/Z/plus).pressed.connect(_button_pressed.bind("z+"))
	($VBoxContainer/Z/minus).pressed.connect(_button_pressed.bind("z-"))

	# connect sliders
	($VBoxContainer/XSlider).value_changed.connect(_slider.bind("x"))
	($VBoxContainer/YSlider).value_changed.connect(_slider.bind("y"))
	($VBoxContainer/ZSlider).value_changed.connect(_slider.bind("z"))
	

# when button is pressed
func _button_pressed(axis: String, increment: int = 1):
	var angles = HeadNode.get_rotation_degrees()
	if (axis == "x+"):
		angles.x += increment
	elif (axis == "x-"):
		angles.x -= increment
	elif (axis == "y+"):
		angles.y += increment
	elif (axis == "y-"):
		angles.y -= increment
	elif (axis == "z+"):
		angles.z += increment
	elif (axis == "z-"):
		angles.z -= increment
	else:
		pass
	HeadNode.set_rotation_degrees(angles)
	_sync_slider()

# when slider value changes
func _slider(value: float, axis: String):
	var angles = HeadNode.get_rotation_degrees()
	if (axis == "x"):
		angles.x = value
	elif (axis == "y"):
		angles.y = value
	elif (axis == "z"):
		angles.z = value
	else:
		pass
	HeadNode.set_rotation_degrees(angles)
	
# set labels
func _set_labels():
	var v = HeadNode.get_rotation_degrees()
	# update labels
	($VBoxContainer/Labels/posX).text = str(round(v.x))
	($VBoxContainer/Labels/posY).text = str(round(v.y))
	($VBoxContainer/Labels/posZ).text = str(round(v.z))
	
# reset angles if out of 0 to 360
func _angles_bound():
	var angles = HeadNode.get_rotation_degrees()
	angles.x = fmod(angles.x, 360.0)
	angles.y = fmod(angles.y, 360)
	angles.z = fmod(angles.z, 360)
	if (angles.x < 0): angles.x += 360
	if (angles.y < 0): angles.y += 360
	if (angles.z < 0): angles.z += 360
	HeadNode.set_rotation_degrees(angles)
	
# sync slider and angle value
func _sync_slider():
	var angles = HeadNode.get_rotation_degrees()
	($VBoxContainer/XSlider).value = angles.x
	($VBoxContainer/YSlider).value = angles.y
	($VBoxContainer/ZSlider).value = angles.z

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_set_labels()
	_angles_bound()
	_sync_slider()
