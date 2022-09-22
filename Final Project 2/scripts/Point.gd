extends Control


func _process(delta):
	$Counter.set_text("Score : " + str(Global.score))
