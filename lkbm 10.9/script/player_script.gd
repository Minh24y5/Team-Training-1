extends KinematicBody2D

var velocity : Vector2 = Vector2()
var direction : Vector2 = Vector2()
var bullet_speed = 1500
var bullet = preload("res://Player/bullet2.tscn")
var fire_rate = 1
var can_fire = true

func read_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		direction = Vector2(0 , -1)
	if Input.is_action_pressed("down"):
		velocity.y += 1
		direction = Vector2(0 , 1)
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		direction = Vector2(-1 , 0)
	if Input.is_action_pressed("right"):
		velocity.x += 1
		direction = Vector2(1 , 0)
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * 400)
	look_at(get_global_mouse_position())
	
	
	if Input.is_action_just_pressed("Shoot") and can_fire == true :
		var bullet_instance = bullet.instance()
		bullet_instance.position = $BulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().call_deferred("add_child" , bullet_instance )
		can_fire = false
		yield(get_tree().create_timer(fire_rate) , "timeout")
		can_fire = true 
		
		
# warning-ignore:unused_argument
func _physics_process(delta):
	look_at(get_global_mouse_position())
	read_input()





