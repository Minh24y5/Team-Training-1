extends KinematicBody2D

var movespeed = 300
func _ready():
	pass
func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		motion.y -= 1
	if Input.is_action_pressed("ui_down"):
		motion.y += 1
	if Input.is_action_pressed("ui_right"):
		motion.x += 1
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1
	
	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)

