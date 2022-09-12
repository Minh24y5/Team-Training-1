extends Control


func _process(delta):
	$Counter.set_text(str(Global.score))
