extends Node


var ammo = 30
var HP = 5


var score = 0

var seconds = 60
var playerposition = 0 
var gunposition = 0

func _physics_process(_delta):
	if seconds >= 61 :
		seconds = 61
