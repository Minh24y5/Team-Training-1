extends Control



# warning-ignore:unused_argument
func _process(delta):

	
	$ammocount.set_text(str(Global.ammo) + " / 5")
	if Global.ammo <= 0 :
		$ammocount.set_text(". . . .")

