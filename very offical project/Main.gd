extends Node2D

onready var Player = $Player

func _physics_process(delta):
	Global.playerposition = Player.position
	
