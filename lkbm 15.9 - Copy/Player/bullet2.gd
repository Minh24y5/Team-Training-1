extends RigidBody2D







func _on_Area2D_body_entered(body):
	if body is StaticBody2D or "Enemy" in body.name  :
		queue_free()
	if "TileMap3" in body.name :
		queue_free()







