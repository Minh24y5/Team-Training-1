extends RigidBody2D








func _on_Area2D_body_entered(body):
	if body is StaticBody2D :
		queue_free()
