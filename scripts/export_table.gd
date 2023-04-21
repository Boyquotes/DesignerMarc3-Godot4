class_name ExportTable

var file : FileAccess
var data : TreeItem

func set_file(_path) -> void:
	self.file = FileAccess.open(_path, FileAccess.WRITE)

func set_tree_data(_root) -> void:
	self.data = _root

func to_csv():
	if self.file == null:
		print("Cannot Open Selected File")
		return
	if !self.file.is_open():
		return
	var header = ["axis", "starttime", "velocity", "acceleration", "deceleration", "position", "duration"]
	self.file.store_csv_line(header)
	var num_points = data.get_child_count()
	var axes : Dictionary = {"X":2, "Y":3, "Z":4}
	for i in range(num_points):
		for axis in axes:
			var row = PackedStringArray()
			var pos = data.get_child(i)
			var vel = data.get_child(i).get_child(0)
			var acc = data.get_child(i).get_child(1)
			var dec = data.get_child(i).get_child(2)
			var dur = data.get_child(i).get_child(3)
			row.append(axis)
			row.append(pos.get_text(0))
			row.append(vel.get_text(axes[axis]))
			row.append(acc.get_text(axes[axis]))
			row.append(dec.get_text(axes[axis]))
			row.append(pos.get_text(axes[axis]))
			row.append(dur.get_text(axes[axis]))
			self.file.store_csv_line(row)
