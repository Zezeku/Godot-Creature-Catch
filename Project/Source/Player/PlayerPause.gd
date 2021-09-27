extends Node

onready var player_controller = null ;

#the scene handler will call this when a switch to route scene
func setPlayerController(body):
	player_controller = body ;

func pausePlayerController():
	player_controller.isActive = false ;
	player_controller.velocity = Vector2.ZERO ;
	player_controller.animationState.travel("Idle") ;

func unpausePlayerController():
	player_controller.isActive = true ;
