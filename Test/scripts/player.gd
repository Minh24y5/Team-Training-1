extends KinematicBody2D



const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500


var velocity = Vector2.ZERO
var bullet_speed = 1500
var bullet = preload("res://Bullet.tscn")
var fire_rate = 0.2
var can_fire = true
var ammo = 5
var reload = 2


onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var BulletPoint = $BulletPoint


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Move/blend_position", input_vector)
		animationState.travel("Move")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("IdleDown")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	if Input.is_action_just_pressed("LMB") and can_fire == true and Global.ammo > 0 :
		Global.ammo -= 1
		var bullet_instance = bullet.instance()
		bullet_instance.position = $BulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().call_deferred("add_child" , bullet_instance )
		can_fire = false
		yield(get_tree().create_timer(fire_rate) , "timeout")
		can_fire = true
		if Global.ammo <= 0 :
			yield(get_tree().create_timer(reload) , "timeout")
			Global.ammo = 5

	velocity = move_and_slide(velocity)
	

	
	
	 
	





	


