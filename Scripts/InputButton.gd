extends Sprite2D

var poggers = false
var good = false
var mid = false
var current_note = null

func _input(event): 
	if event.is_action_pressed("Hit Beat"): 
		if current_note != null:
			if poggers:
				get_parent().increment_score(3)
				current_note.destroy(3)
				print('poggers')
			elif good:
				get_parent().increment_score(2)
				current_note.destroy(2)
				print('good')
			elif mid:
				get_parent().increment_score(1)
				current_note.destroy(1)
				print('mid')
			_reset()
		else:
			get_parent().increment_score(0)
	
	#if event.is_action_pressed(input):
		#frame = 1
	#elif event.is_action_released(input):
		#$PushTimer.start()

func _reset():
	current_note = null
	poggers = false
	good = false
	mid = false

func _on_push_timer_timeout():
	frame = 0

func _on_poggers_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("beat"):
		poggers = true

func _on_poggers_hitbox_area_exited(area: Area2D) -> void:
	if area.is_in_group("beat"):
		poggers = false

func _on_good_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("beat"):
		good = true

func _on_good_hitbox_area_exited(area: Area2D) -> void:
	if area.is_in_group("beat"):
		good = false

func _on_mid_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("beat"):
		mid = true
		current_note = area
		
func _on_mid_hitbox_area_exited(area: Area2D) -> void:
	if area.is_in_group("beat"):
		mid = false
		current_note = null
