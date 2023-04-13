extends HSlider

@onready var camera = get_node("/root/Node3D/CameraLightNode")

func _ready():
	self.value = -camera.rotation_degrees.y
	self.value_changed.connect(_slider)

func _slider(val):
	camera.rotation_degrees.y = -val

func _process(_delta):
	self.tooltip_text = var_to_str(self.value)
