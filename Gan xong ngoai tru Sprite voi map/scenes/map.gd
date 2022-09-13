extends Node2D

onready var Player = get_node("Player")

func _physics_process(delta):
	Global.playerposition = Player.position
	
