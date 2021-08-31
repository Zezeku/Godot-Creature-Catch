extends Node


func _ready():
	pass ;

func isEncounter():
	$Route1Scene.visible = false;
	$Route1Scene/PlayerCamera.current = false ;
	add_child(load("res://Source/BattleScene.tscn").instance()) ;
	$BattleScene/Camera2D.current = true ;
	move_child($BattleScene, 0);
	

func encounterOver():
	remove_child($BattleScene) ;
	##add_child(load("res://Source/Route1Scene.tscn").instance()) ;
	$Route1Scene.visible = true;
	$Route1Scene/PlayerCamera.current = true ;
	move_child($Route1Scene, 0);
