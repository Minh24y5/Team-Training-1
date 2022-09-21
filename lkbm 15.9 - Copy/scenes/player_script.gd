extends KinematicBody2D

enum {
	MOVE,
	ROLL,
	ATTACK
}


const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

var velocity = Vector2.ZERO
var direction : Vector2 = Vector2()
var bullet_speed = 1000
var bullet = preload("res://Player/bullet2.tscn")
var fire_rate = 0.2
var can_fire = true
var hit = false 
var state = MOVE


onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")


func _ready():
	animationTree.active = true


func move_state():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()	
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Move/blend_position", input_vector)
		animationTree.set("parameters/attack/blend_position", input_vector)
		animationState.travel("Move")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * 60)
	else:
		animationState.travel("IdleDown")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * 60)
	


var reload = 2


var invi = false

func read_input2():
		
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
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
		
		
	
func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("attack")

func attack_animation_finished():
	state = MOVE

	if Input.is_action_just_pressed("exit"):
		get_tree().change_scene("res://Startmenu.tscn") 
		

		
# warning-ignore:unused_argument
func _physics_process(delta):
	match state:
		MOVE:
			 move_state()
		ROLL:
			pass
		ATTACK:
			attack_state(delta)
	if Global.HP <= 0 :
		kill()


	move_state()
	read_input2()
	


 

		
		
		
		
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






