extends Node2D

var rand = RandomNumberGenerator.new() 
var enemyscene = load("res://Zombie.tscn")

func _on_Timer_timeout():
	var x = rand.randf_range(151, 694)
	var y = rand.randf_range(45, 525)
	var enemy = enemyscene.instance()
	rand.randomize()
	enemy.position.x = x
	enemy.position.y = y
	add_child(enemy)

