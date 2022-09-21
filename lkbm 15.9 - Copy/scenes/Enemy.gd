extends KinematicBody2D
var speed = 100
var enemyhp = 5



	





func _physics_process(delta):
	var velocity = global_position.direction_to(Global.playerposition)
	move_and_collide(velocity)
	



	
	if enemyhp <= 0 :
		queue_free()
		Global.score += 1
		Global.seconds += 2
		
		


func _on_Area2D_body_entered(body):
	if "Bullet" in body.name :
		enemyhp -= 1




