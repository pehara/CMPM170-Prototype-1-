extends Skeleton2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('hello')
	var animation_player = $AnimationPlayer
	animation_player.play("Move")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
