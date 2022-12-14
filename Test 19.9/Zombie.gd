extends KinematicBody2D

var knockback = Vector2.ZERO

onready var stats = $Stats

func _ready():
	print(stats.max_health)
	print(stats.health)
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	var velocity = global_position.direction_to(Global.playerposition)
	move_and_collide(velocity)
	if stats.health <= 0 :
		queue_free()
		Global.score += 1
		Global.seconds += 2
func _on_Hurtbox_area_entered(area):
	stats.health -=area.damage
	print(stats.health)
	knockback = area.knockback_vector * 150
	

func _on_Stats_no_health():
	queue_free()
