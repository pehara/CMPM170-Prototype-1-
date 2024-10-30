extends Node2D

var score = 0
var combo = 0

var max_combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0

var beat = load("res://Scenes/Beat.tscn")
var instance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

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
