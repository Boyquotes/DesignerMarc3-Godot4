extends VBoxContainer

# checkboxes
@onready var hideXring : CheckBox = $HideXRing
@onready var hideYring : CheckBox = $HideYRing
@onready var hideZdisc : CheckBox = $HideZDisc
@onready var hideSphere : CheckBox = $HideSphere

# objects
@onready var xring : Node3D = get_node("/root/Node3D/XRingOrient/XRingNode")
@onready var yring : Node3D = get_node("/root/Node3D/YRingOrient/YRingNode")
@onready var zdisc : Node3D = get_node("/root/Node3D/ZDiscOrient/DiscNode")
@onready var sphere : Node3D = get_node("/root/Node3D/SphereNode/Sphere")

func _ready():
	_hide_obj(hideXring, xring)
	_hide_obj(hideYring, yring)
	_hide_obj(hideZdisc, zdisc)
	_hide_obj(hideSphere, sphere)

func _hide_obj(check: CheckBox, obj: Node3D):
	check.pressed.connect(func ():
		obj.visible = !check.button_pressed
		)
