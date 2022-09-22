extends Node

var max_health = 6
var health = max_health

signal no_health

func ready():
	if health <= 0:
		emit_signal("no_health")
