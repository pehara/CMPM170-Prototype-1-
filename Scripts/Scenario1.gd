extends Node2D

var score = 0
var combo = 0

var max_combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0

var bpm = 160

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm

var spawn_1_beat = 1
var spawn_2_beat = 0
var spawn_3_beat = 0
var spawn_4_beat = 0

var rand = 0
var beat = load("res://Scenes/Beat.tscn")
var instance

@onready var player_anim = $CharacterBody2D/AnimatedSprite2D
@onready var player_pog = $CharacterBody2D/PlayerPog
@onready var player_good_mid = $CharacterBody2D/PlayerGoodMid
@onready var player_miss = $CharacterBody2D/PlayerMiss

@onready var progress_bar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_anim.play("walk")
	
	randomize()
	$Conductor.play_with_beat_offset(0)
	
	#var progress_bar = $ProgressBar 
	progress_bar.min_value = 0 
	progress_bar.max_value = 10000
	#progress_bar.value = 0 
	change_progress_bar(10000)

func _input(event): 
	if event.is_action_pressed("Spawn Beat"): 
		_spawn_note(1)
	if event.is_action_pressed("Quit"):
		if get_tree().change_scene_to_file("res://Scenes/AURAGAME.tscn") != 0:
			print("Error Changing Scene To Menu")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_conductor_measure(pos):
	if pos == 1:
		_spawn_note(spawn_1_beat)
	elif pos == 2:
		_spawn_note(spawn_2_beat)
	elif pos == 3:
		_spawn_note(spawn_3_beat)
	elif pos == 4:
		_spawn_note(spawn_4_beat)
		
func _on_conductor_beat(pos: Variant) -> void:
	song_position_in_beats = pos
	
	if song_position_in_beats > 36:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats > 98:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats > 132:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 200:
		if progress_bar.value > 9999:
			if get_tree().change_scene_to_file("res://Scenes/GoodEnd.tscn") != OK:
				print ("Error changing scene to End")
		else: 
			if get_tree().change_scene_to_file("res://Scenes/BadEnd.tscn") != OK:
				print ("Error changing scene to End")
			
func _spawn_note(to_spawn):
	if to_spawn > 0:
		instance = beat.instantiate()
		instance.initialize()
		add_child(instance)

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
		
	player_animation_control(by)
	
	score += by * combo
	#change_progress_bar(score)

func reset_combo():
	combo = 0
	
func change_progress_bar(amount):
	progress_bar.value += amount
	if progress_bar.value > progress_bar.max_value or progress_bar.value < 0:
		progress_bar.value = 0
	$Aura.text = "Aura: " + str(progress_bar.value)
	
func player_animation_control(version):
	var anim_time = 0.3
	if version == 3:
		player_anim.visible = false
		player_pog.visible = true
		await get_tree().create_timer(anim_time).timeout
		player_pog.visible = false
		player_anim.visible = true
	elif version == 2 or version == 1:
		player_anim.visible = false
		player_good_mid.visible = true
		await get_tree().create_timer(anim_time).timeout
		player_good_mid.visible = false
		player_anim.visible = true
	else:
		player_anim.visible = false
		player_miss.visible = true
		await get_tree().create_timer(anim_time).timeout
		player_miss.visible = false
		player_anim.visible = true
