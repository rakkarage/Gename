class_name Gename

var one_word := true
var male_chance := 0.5
var neutral_enable := true
var neutral_chance := 0.1
var generated_enable := true
var generated_chance := 0.5
var pre_chance := 0.333
var vowel_chance := 0.8
var middle0_chance := 0.3
var middle1_chance := 0.1
var post_chance := 0.22
const _error := "Error: "
const _name_path := "res://Gename/Name.txt"
const _syllable_path := "res://Gename/Syllable.txt"
const _title_path := "res://Gename/Title.txt"
const _vowel := ['a', 'e', 'i', 'o', 'u', 'y']
var _data := {
	"male": { "name": [], "start": [], "middle": [], "finish": [], "pre": [], "post": [] },
	"female": { "name": [], "start": [], "middle": [], "finish": [], "pre": [], "post": [] },
	"neutral": { "name": [], "start": [], "middle": [], "finish": [], "pre": [], "post": [] }
}
var _rng := RandomNumberGenerator.new()

func _init() -> void:
	_rng.randomize()
	var file := FileAccess.open(_name_path, FileAccess.READ)
	if !file:
		print_debug(_error + _name_path)
		return
	while !file.eof_reached():
		var csv := file.get_csv_line()
		var size := csv.size()
		if size > 0:
			var value := csv[0]
			if value != "":
				_data.male.name.append(value)
		if size > 1:
			var value := csv[1]
			if value != "":
				_data.female.name.append(value)
		if size > 2:
			var value := csv[2]
			if value != "":
				_data.neutral.name.append(value)
	file.close()
	file = FileAccess.open(_syllable_path, FileAccess.READ)
	if !file:
		print_debug(_error + _syllable_path)
		return
	while !file.eof_reached():
		var csv := file.get_csv_line()
		var size := csv.size()
		if size > 0:
			var value := csv[0]
			if value != "":
				_data.male.start.append(value)
		if size > 1:
			var value := csv[1]
			if value != "":
				_data.male.middle.append(value)
		if size > 2:
			var value := csv[2]
			if value != "":
				_data.male.finish.append(value)
		if size > 3:
			var value := csv[3]
			if value != "":
				_data.female.start.append(value)
		if size > 4:
			var value := csv[4]
			if value != "":
				_data.female.middle.append(value)
		if size > 5:
			var value := csv[5]
			if value != "":
				_data.female.finish.append(value)
		if size > 6:
			var value := csv[6]
			if value != "":
				_data.neutral.start.append(value)
		if size > 7:
			var value := csv[7]
			if value != "":
				_data.neutral.middle.append(value)
		if size > 8:
			var value := csv[8]
			if value != "":
				_data.neutral.finish.append(value)
	file.close()
	file = FileAccess.open(_title_path, file.READ)
	if !file:
		print_debug(_error + _title_path)
		return
	while !file.eof_reached():
		var csv := file.get_csv_line()
		var size := csv.size()
		if size > 0:
			var value := csv[0]
			if value != "":
				_data.male.pre.append(value)
		if size > 1:
			var value := csv[1]
			if value != "":
				_data.male.post.append(value)
		if size > 2:
			var value := csv[2]
			if value != "":
				_data.female.pre.append(value)
		if size > 3:
			var value := csv[3]
			if value != "":
				_data.female.post.append(value)
		if size > 4:
			var value := csv[4]
			if value != "":
				_data.neutral.pre.append(value)
		if size > 5:
			var value := csv[5]
			if value != "":
				_data.neutral.post.append(value)
	file.close()

func _random(array: Array) -> String:
	var size := array.size()
	return "" if size == 0 else array[_rng.randi() % size]
func _male_pre() -> String: return _random(_data.male.pre)
func _female_pre() -> String: return _random(_data.female.pre)
func _neutral_pre() -> String: return _random(_data.neutral.pre)
func _male_start() -> String: return _random(_data.male.start)
func _female_start() -> String: return _random(_data.female.start)
func _neutral_start() -> String: return _random(_data.neutral.start)
func _male_middle() -> String: return _random(_data.male.middle)
func _female_middle() -> String: return _random(_data.female.middle)
func _neutral_middle() -> String: return _random(_data.neutral.middle)
func _male_finish() -> String: return _random(_data.male.finish)
func _female_finish() -> String: return _random(_data.female.finish)
func _neutral_finish() -> String: return _random(_data.neutral.finish)
func _male_name() -> String: return _random(_data.male.name)
func _female_name() -> String: return _random(_data.female.name)
func _neutral_name() -> String: return _random(_data.neutral.name)
func _male_post() -> String: return _random(_data.male.post)
func _female_post() -> String: return _random(_data.female.post)
func _neutral_post() -> String: return _random(_data.neutral.post)

func next() -> String:
	var name := ""
	var male := male_chance > _rng.randf()
	var neutral := neutral_enable and neutral_chance > _rng.randf()
	if one_word == false and pre_chance > _rng.randf():
		name += _neutral_pre() if neutral else _male_pre() if male else _female_pre()
		name += " "
		post_chance += 0.5
	if generated_enable and generated_chance > _rng.randf():
		name += _neutral_start() if neutral else _male_start() if male else _female_start()
		if vowel_chance > _rng.randf():
			name += _random(_vowel)
		if middle0_chance > _rng.randf():
			name += _neutral_middle() if neutral else _male_middle() if male else _female_middle()
		if middle1_chance > _rng.randf():
			name += _neutral_middle() if neutral else _male_middle() if male else _female_middle()
		name += _neutral_finish() if neutral else _male_finish() if male else _female_finish()
	else:
		name += _neutral_name() if neutral else _male_name() if male else _female_name()
	if one_word == false and post_chance > _rng.randf():
		name += " "
		name += _neutral_post() if neutral else _male_post() if male else _female_post()
	return name
