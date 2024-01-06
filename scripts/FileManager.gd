

static func list_files_in_directory(path: String):
		var files = []
		var dir = Directory.new()

		dir.open(path)
		dir.list_dir_begin()

		while true:
			var file = dir.get_next()
			if file == "":
				break
			elif not file.begins_with("."):
				files.append(file)
		
		return files

static func get_json_from_file(path: String, file_name: String):
	var file = File.new()
	file.open(path + file_name, File.READ)

	var json_string = file.get_as_text()
	file.close()

	var json = JSON.parse(json_string)
	return json

static func get_json_array_from_files(path: String, file_names: Array):
	var json_array = []

	for file in file_names:
		var json = get_json_from_file(path, file)
		json_array.append(json)
		
	return json_array