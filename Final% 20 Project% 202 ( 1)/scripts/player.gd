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
var hit = false
var invi = false


onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
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
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Move")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move()
	
	if Input.is_action_just_pressed("Attack"):
		state = ATTACK
	

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
		
	

	if Global.HP <= 0:
		kill()
	if Global.seconds <= 0:
		get_tree().change_scene("res://game/GameOverScreen.tscn")

	if hit == true and invi == false :
		Global.HP -=1 
		invi = true
		yield(get_tree().create_timer(1.0), "timeout")
		invi = false


	
func attack_state(delta):
	$AudioStreamPlayer2D.play()
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func move():
	velocity = move_and_slide(velocity)


	
func attack_animation_finished():
	state = MOVE



func kill():
	Global.HP = 5
	
	Global.score = 0
	Global.seconds = 60
	get_tree().reload_current_scene() 
	get_tree().change_scene("res://game/GameOverScreen.tscn")


func _on_Hurtbox_area_entered(area):
	hit = true


func _on_Hurtbox_area_exited(area):
	hit = false
