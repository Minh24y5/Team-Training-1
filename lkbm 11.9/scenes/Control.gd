extends Control

export (int) var minutes = 0
export (int) var seconds = 0


func _physics_process(delta):
	if seconds == 0 :
		return





func _on_Timer_timeout():
	seconds -=1
	if seconds >= 10 :
		$sec.set_text(str(seconds))
	else : 
		$sec.set_text("0" + str(seconds))
	if seconds <= 0 :
		seconds = 1
	
