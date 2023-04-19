extends Control

@onready var camera : Node3D = get_node("/root/Node3D/CameraLightNode")
@onready var hslider : HSlider = $HSlider
@onready var vslider : VSlider = $VSlider

func _ready():
	hslider.value = -camera.rotation_degrees.y
	hslider.value_changed.connect(_hslider_value_changed)
	
	vslider.value = camera.rotation_degrees.x
	vslider.value_changed.connect(_vslider_value_changed)

func _hslider_value_changed(val):
	camera.rotation_degrees.y = -val

func _vslider_value_changed(val):
	camera.rotation_degrees.x = val

func _process(_delta):
	hslider.tooltip_text = var_to_str(hslider.value)
	vslider.tooltip_text = var_to_str(vslider.value)
