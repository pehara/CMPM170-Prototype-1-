extends Skeleton2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var animation_player = $AnimationPlayer
	animation_player.play("Move")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	var animation_player = $AnimationPlayer 
	animation_player.play(anim_name)
