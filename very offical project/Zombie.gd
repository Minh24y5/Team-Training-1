extends KinematicBody2D

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO

const ACCELERATION = 400
const MAX_SPEED = 60
const FRICTION = 500

enum {
	IDLE,
	CHASE
}

var state = CHASE
onready var stats = $Stats
onready var playerDetectionZone = $playerDetectionZone

func _ready():
	print(stats.max_health)
	print(stats.health)
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 400 * delta)
	knockback = move_and_slide(knockback)
	match state:
		IDLE:
			velocity =velocity.move_toward(Vector2.ZERO , FRICTION * delta)
			seek_player()
		
		CHASE:
			var player = $playerDetectionZone.player
			if player != null:
				var direction = (Global.playerposition - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)
	if stats.health <= 0 :
		_on_Stats_no_health()
func _on_Hurtbox_area_entered(area):
	stats.health -=area.damage
	print(stats.health)
	knockback = area.knockback_vector * 170



func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
func _on_Stats_no_health():
	
	queue_free()
	Global.score += 1
	Global.seconds += 3
	if Global.HP < 5:
		Global.HP += 1
	$HitSound.play()









func _on_Hurtbox_body_entered(body):
	if "Bullet" in body.name :
		stats.health -= 2
		$HitSound.play()








func _on_Timer_timeout():
	if $AnimatedSprite.flip_h == false :
		$AnimatedSprite.flip_h = true 
	else :
		$AnimatedSprite.flip_h = false
