extends Node2D



var bullet_speed = 1000
var bullet = preload("res://Player/bullet2.tscn")
var fire_rate = 0.2
var can_fire = true
var hit = false 
var reload = 2
export var offset : float = 0






func _physics_process(delta):
	look_at(get_global_mouse_position())
	read_input()
	Global.gunposition = self.position

	position.x = Global.playerposition.x + offset
	position.y = Global.playerposition.y 








func read_input():
	if Input.is_action_just_pressed("Shoot") and can_fire == true and Global.ammo > 0 :
		Global.ammo -= 1
		var bullet_instance = bullet.instance()
		bullet_instance.position = Global.gunposition
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().call_deferred("add_child" , bullet_instance )
		can_fire = false
		yield(get_tree().create_timer(fire_rate) , "timeout")
		can_fire = true
		if Global.ammo <= 0 :
			yield(get_tree().create_timer(reload) , "timeout")
			Global.ammo = 30
