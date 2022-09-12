extends Control




func _on_Retry_pressed():
	get_tree().change_scene("res://scenes/map.tscn") 
	Global.ammo = 30 
	Global.HP = 5
	Global.enemyhp = 5
	Global.score = 0
	Global.seconds = 60



func _on_Return_pressed():
	get_tree().change_scene("res://Startmenu.tscn")
