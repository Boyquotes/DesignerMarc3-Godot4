extends HSlider

@onready var camera = get_node("/root/Node3D/CameraLightNode")

func _ready():
	self.value_changed.connect(_slider)

func _slider(val):
	camera.rotation_degrees.x = val

func _process(_delta):
	self.value = camera.rotation_degrees.x
