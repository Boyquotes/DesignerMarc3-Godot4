extends CheckBox

@onready var disc = get_node("/root/Node3D/ZDiscOrient/DiscNode")

func _ready():
	self.pressed.connect(_checked)

func _checked():
	disc.visible = !self.button_pressed
