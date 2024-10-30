extends Node2D

var score = 0
var combo = 0

var max_combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0

var bpm = 115

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm


var beat = load("res://Scenes/Beat.tscn")
var instance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Conductor.play_with_beat_offset(0)

func _input(event): 
	if event.is_action_pressed("Spawn Beat"): 
		_spawn_note()
	if event.is_action_pressed("Quit"):
		if get_tree().change_scene_to_file("res://Scenes/AURAGAME.tscn") != 0:
			print("Error Changing Scene To Menu")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func increment_score(by):
	if by > 0:
		combo += 1
	else:
		combo = 0
	
	if by == 3:
		great += 1
	elif by == 2:
		good += 1
	elif by == 1:
		okay += 1
	else:
		missed += 1
	
	
	score += by * combo
	$Aura.text = "Aura: " + str(score)
	#if combo > 0:
		#$Combo.text = str(combo) + " combo!"
		#if combo > max_combo:
			#max_combo = combo
	#else:
		#$Combo.text = ""

func _spawn_note():
	instance = beat.instantiate()
	instance.initialize()
	add_child(instance)


func _on_conductor_beat(pos: Variant) -> void:
	song_position_in_beats = pos
	_spawn_note()
	
	#if song_position_in_beats > 36:
	if song_position_in_beats > 404:
		#Global.set_score(score)
		#Global.combo = max_combo
		#Global.great = great
		#Global.good = good
		#Global.okay = okay
		#Global.missed = missed
		if get_tree().change_scene_to_file("res://Scenes/End.tscn") != OK:
			print ("Error changing scene to End")


func _on_conductor_measure(pos: Variant) -> void:
	#_spawn_note()
	print('e')
