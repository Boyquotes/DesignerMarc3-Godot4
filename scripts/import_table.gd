class_name ImportTable

var file : FileAccess
var data : Dictionary

func set_file(_path) -> void:
	print(_path)
	self.file = FileAccess.open(_path, FileAccess.READ)

func get_tree_data() -> Dictionary:
	return self.data

func from_csv():
	if self.file == null:
		print("Cannot Open Selected File")
		return
	if !self.file.is_open():
		return
	var _header = self.file.get_csv_line()
	while not self.file.eof_reached():
		var row = self.file.get_csv_line()
		if row.size() < 7:
			continue
		if self.data.has(row[1]) == false:
			self.data[row[1]] = {}
		self.data[row[1]][row[0]] = {
			"pos" : row[5],
			"vel" : row[2],
			"acc" : row[3],
			"dec" : row[4],
			"dur" : row[6]
		}
