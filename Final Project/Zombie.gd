extends KinematicBody2D

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO

const ACCELERATION = 400
const MAX_SPEED = 50
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
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)
	if stats.health <= 0 :
		_on_Stats_no_health()
func _on_Hurtbox_area_entered(area):
	stats.health -=area.damage
	print(stats.health)
	knockback = area.knockback_vector * 150


func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
func _on_Stats_no_health():
	queue_free()
	Global.score += 0.5
	Global.seconds += 2.5
	if Global.HP < 5:
		Global.HP += 0.5




