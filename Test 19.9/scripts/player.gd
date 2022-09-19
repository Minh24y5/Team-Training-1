extends KinematicBody2D



const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

enum{
	MOVE,
	ATTACK
}

var state = MOVE

var velocity = Vector2.ZERO
var roll_vector = Vector2.LEFT
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
onready var swordHitbox = $HitboxPivot/SwordHitbox

func _ready():
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()	
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Move/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Move")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("Attack"):
		state = ATTACK

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
	
	shoot()

func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func shoot():
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
	
	
	
	 
	
func attack_animation_finished():
	state = MOVE




	


