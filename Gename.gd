extends Object
class_name Gename

var oneWord = true
var maleChance: float = 0.5
var neutralEnable: bool = true
var neutralChance: float = 0.1
var generatedEnable: bool = true
var generatedChance: float = 0.5
var preChance: float = 0.333
var vowelChance: float = 0.8
var middle0Chance: float = 0.3
var middle1Chance: float = 0.1
var postChance: float = 0.22

const _vowel := ['a', 'e', 'i', 'o', 'u', 'y']

var _data := {
	"male": { "name": [], "start": [], "middle": [], "finish": [], "pre": [], "post": [] },
	"female": { "name": [], "start": [], "middle": [], "finish": [], "pre": [], "post": [] },
	"neutral": { "name": [], "start": [], "middle": [], "finish": [], "pre": [], "post": [] }
}

var _rng := RandomNumberGenerator.new()

func _init() -> void:
	_rng.randomize()
	var file = File.new()
	file.open("res://Gename/Name.csv", file.READ)
	while !file.eof_reached():
		var csv = file.get_csv_line()
		var size = csv.size()
		if size > 0:
			var value = csv[0]
			if value != "":
				_data.male.name.append(value)
		if size > 1:
			var value = csv[1]
			if value != "":
				_data.female.name.append(value)
		if size > 2:
			var value = csv[2]
			if value != "":
				_data.neutral.name.append(value)
	file.close()
	file.open("res://Gename/Syllable.csv", file.READ)
	while !file.eof_reached():
		var csv = file.get_csv_line()
		var size = csv.size()
		if size > 0:
			var value = csv[0]
			if value != "":
				_data.male.start.append(value)
		if size > 1:
			var value = csv[1]
			if value != "":
				_data.male.middle.append(value)
		if size > 2:
			var value = csv[2]
			if value != "":
				_data.male.finish.append(value)
		if size > 3:
			var value = csv[3]
			if value != "":
				_data.female.start.append(value)
		if size > 4:
			var value = csv[4]
			if value != "":
				_data.female.middle.append(value)
		if size > 5:
			var value = csv[5]
			if value != "":
				_data.female.finish.append(value)
		if size > 6:
			var value = csv[6]
			if value != "":
				_data.neutral.start.append(value)
		if size > 7:
			var value = csv[7]
			if value != "":
				_data.neutral.middle.append(value)
		if size > 8:
			var value = csv[8]
			if value != "":
				_data.neutral.finish.append(value)
	file.close()
	file.open("res://Gename/Title.csv", file.READ)
	while !file.eof_reached():
		var csv = file.get_csv_line()
		var size = csv.size()
		if size > 0:
			var value = csv[0]
			if value != "":
				_data.male.pre.append(value)
		if size > 1:
			var value = csv[1]
			if value != "":
				_data.male.post.append(value)
		if size > 2:
			var value = csv[2]
			if value != "":
				_data.female.pre.append(value)
		if size > 3:
			var value = csv[3]
			if value != "":
				_data.female.post.append(value)
		if size > 4:
			var value = csv[4]
			if value != "":
				_data.neutral.pre.append(value)
		if size > 5:
			var value = csv[5]
			if value != "":
				_data.neutral.post.append(value)
	file.close()

func _random(array: Array) -> String:
	return array[_rng.randi() % array.size()]
func _malePre() -> String:	return _random(_data.male.pre)
func _femalePre() -> String: return _random(_data.female.pre)
func _neutralPre() -> String: return _random(_data.neutral.pre)
func _maleStart() -> String: return _random(_data.male.start)
func _femaleStart() -> String: return _random(_data.female.pre)
func _neutralStart() -> String: return _random(_data.neutral.pre)
func _maleMiddle() -> String: return _random(_data.male.middle)
func _femaleMiddle() -> String: return _random(_data.female.middle)
func _neutralMiddle() -> String: return _random(_data.neutral.middle)
func _maleFinish() -> String: return _random(_data.male.finish)
func _femaleFinish() -> String: return _random(_data.female.finish)
func _neutralFinish() -> String: return _random(_data.neutral.finish)
func _maleName() -> String: return _random(_data.male.name)
func _femaleName() -> String: return _random(_data.female.name)
func _neutralName() -> String: return _random(_data.neutral.name)
func _malePost() -> String: return _random(_data.male.post)
func _femalePost() -> String: return _random(_data.female.post)
func _neutralPost() -> String: return _random(_data.neutral.post)

func next() -> String:
	var name = ""
	var male = maleChance > _rng.randf()
	var neutral = neutralEnable and neutralChance > _rng.randf()
	if oneWord == false and preChance > _rng.randf():
		name += _neutralPre() if neutral else _malePre() if male else _femalePre()
		name += " "
		postChance += 0.5
	if generatedEnable and generatedChance > _rng.randf():
		name += _neutralStart() if neutral else _maleStart() if male else _femaleStart()
		if vowelChance > _rng.randf():
			name += _random(_vowel)
		if middle0Chance > _rng.randf():
			name += _neutralMiddle() if neutral else _maleMiddle() if male else _femaleMiddle()
		if middle1Chance > _rng.randf():
			name += _neutralMiddle() if neutral else _maleMiddle() if male else _femaleMiddle()
		name += _neutralFinish() if neutral else _maleFinish() if male else _femaleFinish()
	else:
		name += _neutralName() if neutral else _maleName() if male else _femaleName()
	if oneWord == false and postChance > _rng.randf():
		name += " "
		name += _neutralName() if neutral else _maleName() if male else _femaleName()
	return name
