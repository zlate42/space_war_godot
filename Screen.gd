extends CanvasLayer

func appear():
	$AnimationPlayer.play('appear')

func disappear():
	$AnimationPlayer.play_backwards('appear')
