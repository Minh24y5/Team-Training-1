extends RigidBody2D







func _on_Area2D_body_entered(body):
	if body is StaticBody2D or "Enemy" in body.name  :
		Global.enemyhp -= 1
		queue_free()








