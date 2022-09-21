extends CanvasLayer



func _on_Button_pressed():
	$AudioStreamPlayer2D.play()
	get_tree().change_scene("res://Main.tscn")


func _on_Button2_pressed():
	$AudioStreamPlayer2D.play()
	get_tree().quit()
