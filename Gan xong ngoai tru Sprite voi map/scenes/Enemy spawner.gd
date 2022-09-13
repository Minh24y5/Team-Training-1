extends Node


var rand = RandomNumberGenerator.new() 
var enemyscene = load("res://mob.tscn")






func _on_Timer_timeout():
	var x = rand.randf_range(-400 , 400)
	var y = rand.randf_range(-400, 400)
	var enemy = enemyscene.instance()

	rand.randomize()
	enemy.position.x = x
	enemy.position.y = y
	add_child(enemy)


