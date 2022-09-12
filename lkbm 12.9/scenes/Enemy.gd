extends KinematicBody2D
var speed = 3
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var motion = Vector2()

	
	motion += (Vector2(Global.playerposition) - position)
	look_at(Global.playerposition)
	
	motion = motion.normalized() * speed
	move_and_collide(motion)
	
	if Global.enemyhp <= 0 :
		queue_free()
		Global.HP = 5
