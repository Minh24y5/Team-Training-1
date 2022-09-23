extends Control
export (int) var seconds = 0


func _on_Timer_timeout():
	Global.seconds -=1
	if Global.seconds >= 10 :
		$sec.set_text(str(Global.seconds))
	else : 
		$sec.set_text("0" + str(Global.seconds))
	if Global.seconds < 0 :
		Global.seconds = 1
