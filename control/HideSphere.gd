extends CheckBox

@onready var sphere = get_node("/root/Node3D/SphereNode/Sphere")

func _ready():
	self.pressed.connect(func ():
		sphere.visible = !self.button_pressed
		)
