extends Node



var HP = 5


var score = 0 

var seconds = 60
var playerposition = null 
var gunposition = null

func _physics_process(_delta):
	if seconds >= 61 :
		seconds = 61
