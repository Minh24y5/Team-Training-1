extends Area2D

var player = null

func can_See_player():
	return player != null


func _on_playerDetectionZone_body_entered(body):
	player = body


func _on_playerDetectionZone_body_exited(body):
	player = null
