extends CheckBox

@onready var ring = get_node("/root/Node3D/XRingOrient/XRingNode")

func _ready():
	self.pressed.connect(_checked)

func _checked():
	ring.visible = !self.button_pressed
