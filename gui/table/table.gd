extends VBoxContainer

@onready var main : Node3D = get_node("/root/Node3D")
@onready var tree : Tree = $Tree
@onready var addButton : Button = $Buttons/Add
@onready var editButton : Button = $Buttons/Edit
@onready var saveButton : Button = $Buttons/Save
@onready var deleteButton : Button = $Buttons/Delete
@onready var clearButton: Button = $Clear
@onready var importButton : Button = $FileOperations/Import
@onready var exportButton : Button = $FileOperations/Export
@onready var xslider : HSlider = get_node("/root/Node3D/GUI/Setter/X/slider")
@onready var yslider : HSlider = get_node("/root/Node3D/GUI/Setter/Y/slider")
@onready var zslider : HSlider = get_node("/root/Node3D/GUI/Setter/Z/slider")
@onready var xvel : SpinBox = get_node("/root/Node3D/GUI/Setter/XOthers/vel")
@onready var yvel : SpinBox = get_node("/root/Node3D/GUI/Setter/YOthers/vel")
@onready var zvel : SpinBox = get_node("/root/Node3D/GUI/Setter/ZOthers/vel")
@onready var xacc : SpinBox = get_node("/root/Node3D/GUI/Setter/XOthers/acc")
@onready var yacc : SpinBox = get_node("/root/Node3D/GUI/Setter/YOthers/acc")
@onready var zacc : SpinBox = get_node("/root/Node3D/GUI/Setter/ZOthers/acc")
@onready var xdec : SpinBox = get_node("/root/Node3D/GUI/Setter/XOthers/dec")
@onready var ydec : SpinBox = get_node("/root/Node3D/GUI/Setter/YOthers/dec")
@onready var zdec : SpinBox = get_node("/root/Node3D/GUI/Setter/ZOthers/dec")
@onready var duration : SpinBox = get_node("/root/Node3D/GUI/Setter/Common/duration")

var selectedItem : TreeItem
var root : TreeItem
var importFile : String
var exportFile : String

func _ready():
	# set column widths
	var col_width = (self.size.x / tree.columns) - 5
	for i in tree.columns:
		tree.set_column_custom_minimum_width(i, col_width)
	# create root item
	root = tree.create_item()
	# set titles
	tree.set_column_title(0, "#")
	tree.set_column_title(1, "Qty")
	tree.set_column_title(2, "X")
	tree.set_column_title(3, "Y")
	tree.set_column_title(4, "Z")
	# tree selection changed
	tree.item_selected.connect(_selection_changed)
	
	# assign buttons func
	addButton.pressed.connect(_add_button_pressed)
	editButton.pressed.connect(_edit_button_pressed)
	saveButton.pressed.connect(_save_button_pressed)
	deleteButton.pressed.connect(_delete_button_pressed)
	clearButton.pressed.connect(_clear_button_pressed)
	importButton.pressed.connect(_import_button_pressed)
	exportButton.pressed.connect(_export_button_pressed)
	# clear selection on ready
	_clear_button_pressed()
	
func _selection_changed():
	saveButton.disabled = true
	addButton.disabled = true
	editButton.disabled = false
	deleteButton.disabled = false

func _add_button_pressed():
	var child = root.create_child()
	child.collapsed = true
	child.set_text(0, str(child.get_index()))
	# position values
	child.set_text(1, "Pos:")
	child.set_text(2, str(xslider.value))
	child.set_text(3, str(yslider.value))
	child.set_text(4, str(zslider.value))
	# velocity values
	var subchild1 = child.create_child()
	subchild1.set_text(1, "Vel:")
	subchild1.set_text(2, str(xvel.value))
	subchild1.set_text(3, str(yvel.value))
	subchild1.set_text(4, str(zvel.value))
	# acceleration values
	var subchild2 = child.create_child()
	subchild2.set_text(1, "Acc:")
	subchild2.set_text(2, str(xacc.value))
	subchild2.set_text(3, str(yacc.value))
	subchild2.set_text(4, str(zacc.value))
	# deceleration values
	var subchild3 = child.create_child()
	subchild3.set_text(1, "Dec:")
	subchild3.set_text(2, str(xdec.value))
	subchild3.set_text(3, str(ydec.value))
	subchild3.set_text(4, str(zdec.value))
	# duration values
	var subchild4 = child.create_child()
	subchild4.set_text(1, "Dur:")
	subchild4.set_text(2, str(duration.value))
	subchild4.set_text(3, str(duration.value))
	subchild4.set_text(4, str(duration.value))
	# center align
	for i in tree.columns:
		child.set_text_alignment(i, HORIZONTAL_ALIGNMENT_CENTER)
		subchild1.set_text_alignment(i, HORIZONTAL_ALIGNMENT_CENTER)
		subchild2.set_text_alignment(i, HORIZONTAL_ALIGNMENT_CENTER)
		subchild3.set_text_alignment(i, HORIZONTAL_ALIGNMENT_CENTER)
		subchild4.set_text_alignment(i, HORIZONTAL_ALIGNMENT_CENTER)

func _edit_button_pressed():
	# get the selection
	selectedItem = tree.get_selected()
	# if nothing selected
	if not is_instance_valid(selectedItem):
		return
	# enable save button and disable others
	saveButton.disabled = false
	addButton.disabled = true
	editButton.disabled = true
	deleteButton.disabled = true
	# set slider values to currently selected item
	xslider.value = int(selectedItem.get_text(2))
	yslider.value = int(selectedItem.get_text(3))
	zslider.value = int(selectedItem.get_text(4))
	# set vel, acc, dec values
	xvel.value = int(selectedItem.get_child(0).get_text(2))
	yvel.value = int(selectedItem.get_child(0).get_text(3))
	zvel.value = int(selectedItem.get_child(0).get_text(4))
	xacc.value = int(selectedItem.get_child(1).get_text(2))
	yacc.value = int(selectedItem.get_child(1).get_text(3))
	zacc.value = int(selectedItem.get_child(1).get_text(4))
	xdec.value = int(selectedItem.get_child(2).get_text(2))
	ydec.value = int(selectedItem.get_child(2).get_text(3))
	zdec.value = int(selectedItem.get_child(2).get_text(4))

func _save_button_pressed():
	# pos value
	selectedItem.set_text(2, str(xslider.value))
	selectedItem.set_text(3, str(yslider.value))
	selectedItem.set_text(4, str(zslider.value))
	# vel values
	selectedItem.get_child(0).set_text(2, str(xvel.value))
	selectedItem.get_child(0).set_text(3, str(yvel.value))
	selectedItem.get_child(0).set_text(4, str(zvel.value))
	# acc values
	selectedItem.get_child(1).set_text(2, str(xacc.value))
	selectedItem.get_child(1).set_text(3, str(yacc.value))
	selectedItem.get_child(1).set_text(4, str(zacc.value))
	# dec values
	selectedItem.get_child(2).set_text(2, str(xdec.value))
	selectedItem.get_child(2).set_text(3, str(ydec.value))
	selectedItem.get_child(2).set_text(4, str(zdec.value))
	# dur values
	selectedItem.get_child(3).set_text(2, str(duration.value))
	selectedItem.get_child(3).set_text(3, str(duration.value))
	selectedItem.get_child(3).set_text(4, str(duration.value))
	_clear_button_pressed()

func _delete_button_pressed():
	# get the selection
	selectedItem = tree.get_selected()
	# if nothing selected
	if not is_instance_valid(selectedItem):
		return
	root.remove_child(selectedItem)
	# update index number
	var currentItem : TreeItem = root.get_child(0)
	while currentItem:
		currentItem.set_text(0, str(currentItem.get_index()))
		currentItem = currentItem.get_next()
	_clear_button_pressed()

func _clear_button_pressed():
	tree.deselect_all()
	addButton.disabled = false
	editButton.disabled = true
	deleteButton.disabled = true
	saveButton.disabled = true
	
func _import_button_pressed():
	pass

func _export_button_pressed():
	var exportDialog : FileDialog = get_node("/root/Node3D/GUI/FileDialog/Export")
	exportDialog.show()
	exportDialog.file_selected.connect(_on_export_file_selected)

func _on_export_file_selected(_path):
	var exportCSV = ExportTable.new()
	exportCSV.set_file(_path)
	exportCSV.set_tree_data(root)
	exportCSV.to_csv()
