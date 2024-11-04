extends Area2D

const TARGET_X = 195
const SPAWN_X = 1200
const DIST_TO_TARGET = TARGET_X - SPAWN_X

var speed = 0
var hit = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta):
	if !hit:
		position.x += speed * delta
		if position.x < 0:
			#var progress_bar = get_parent().get_node("ProgressBar")
			#progress_bar.value -= 500 
			#if progress_bar.value < 0: 
				#progress_bar.value = 0
			get_parent().change_progress_bar(-500)
			get_parent().player_animation_control(0)
			queue_free()
			get_parent().reset_combo()
	else:
		$Node2D.position.y += speed * delta

func initialize():
	position = Vector2(SPAWN_X, 540)
	speed = DIST_TO_TARGET / 2.0

func destroy(score):
	#$CPUParticles2D.emitting = true
	$Sprite2D.visible = false
	$Timer.start()
	hit = true
	if score == 3:
		$Node2D/Label.text = "POG"
		$Node2D/Label.modulate = Color("f6d6bd")
	elif score == 2:
		$Node2D/Label.text = "GOOD"
		$Node2D/Label.modulate = Color("c3a38a")
	elif score == 1:
		$Node2D/Label.text = "MID"
		$Node2D/Label.modulate = Color("997577")

func _on_timer_timeout():
	queue_free()
