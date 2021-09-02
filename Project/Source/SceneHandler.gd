extends Node


enum{ 
	WORLD, 
	MENU, 
	BATTLE
	} ;

var state = WORLD ;
var player_pos ;
var player_frame ;

func _ready():
	pass ;

func change_state(state):
	match state:
		WORLD:
			world_state() ;
		BATTLE:
			battle_state() ;
		MENU:
			pass

func world_state():
	add_child(load("res://Source/Route1Scene.tscn").instance()) ;
	$Route1Scene/YSort/Player/PlayerCamera.current = true ;
	move_child($Route1Scene, 0);
	
	$Route1Scene/YSort/Player.transform = player_pos ;
	$Route1Scene/YSort/Player.animationTree.set("parameters/Idle/blend_position", player_frame);
	

func battle_state():
	add_child(load("res://Source/BattleScene.tscn").instance()) ;
	$BattleScene/Camera2D.current = true ;
	move_child($BattleScene, 0);


func change_to_world_state():
	state = WORLD ;
	remove_child($BattleScene) ;
	change_state(state) ;
	
func change_to_battle_state():
	state = BATTLE ;
	
	player_pos = $Route1Scene/YSort/Player.transform ;
	player_frame = $Route1Scene/YSort/Player.animationTree.get("parameters/Idle/blend_position");
	
	remove_child($Route1Scene);
	change_state(state) ;
	
	


	
	
