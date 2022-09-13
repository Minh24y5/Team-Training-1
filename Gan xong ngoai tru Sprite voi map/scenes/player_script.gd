extends KinematicBody2D


var velocity : Vector2 = Vector2()
var direction : Vector2 = Vector2()
var bullet_speed = 1000
var bullet = preload("res://Player/bullet2.tscn")
var fire_rate = 0.2
var can_fire = true
var hit = false 

var reload = 2


var invi = false

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
	
	
	
	if Input.is_action_just_pressed("Shoot") and can_fire == true and Global.ammo > 0 :
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
			Global.ammo = 30

		

	if Input.is_action_just_pressed("exit"):
		get_tree().change_scene("res://Startmenu.tscn") 
		

		
# warning-ignore:unused_argument
func _physics_process(delta):
	
	
	
	
	
	
	
	
	if Global.HP <= 0 :
		kill()

	look_at(get_global_mouse_position())
	read_input()
	


 

		
		
		
		
	if Input.is_action_just_pressed("exit"):
		Global.ammo = 30
		Global.HP = 5
		
		Global.score = 0
		Global.seconds = 60
		
		
	
	if Global.seconds <=0 :
		get_tree().change_scene("res://gameover.tscn")



	if hit == true and invi == false :
		Global.HP -=1 
		invi = true
		yield(get_tree().create_timer(1.0), "timeout")
		invi = false


func kill():
	Global.ammo = 30 
	Global.HP = 5
	
	Global.score = 0
	Global.seconds = 60
	get_tree().reload_current_scene() 
	get_tree().change_scene("res://gameover.tscn")













func _on_Hitbox_body_entered(body):
	if "Enemy" in body.name :
		hit = true 

		
		


func _on_Hitbox_body_exited(body):
	if "Enemy" in body.name :
		hit = false 
