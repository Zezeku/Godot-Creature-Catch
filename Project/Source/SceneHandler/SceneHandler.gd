extends Node

#onready var root = get_tree().root
#onready var base_size = root.get_visible_rect().size

#loaded scripts/class
onready var playerPause = load("res://Source/Player/PlayerPause.gd").new() ;
onready var routeHandler = load("res://Source/RouteScenes/RouteHandler.gd").new() ;


#DATA STORAGE FOR BATTLE SCENE
#LOOK INTO ADDING DICTIONARY INTO ROUTEHANDLER FOR BATTLE SCENEs
var cur_route = null ;
var cur_route_name = null ;
var cur_route_path = null ;
var battle_data = [] ;

var battle_background = null ;

enum{ 
	WORLD, 
	MENU, 
	BATTLE
	} ;

var state = null ;
var player_pos = Vector2.ZERO;
var player_frame = 0;
var player_z_index = 1 ;

func _ready():
#	get_tree().connect("screen_resized", self, "_on_screen_resized")
	
#	root.set_attach_to_screen_rect(root.get_visible_rect())
#	_on_screen_resized()
	add_child(load("res://Source/Player/Player.tscn").instance()) ;
	add_child(load("res://Source/Player/PlayerMenu.tscn").instance()) ;
	add_child(load("res://Source/NPCs/DialogueSystem.tscn").instance()) ;
	
# warning-ignore:return_value_discarded
	$Player.connect("updateCreatureSlot", $PlayerMenu, "updateCreatureSlot") ;
	
	
	add_child(load("res://Source/TitleScreen/TitleScreen.tscn").instance()) ;
# warning-ignore:return_value_discarded
	$TitleScreen.connect("loadScene", self, "LoadScene") ;
	

func LoadScene(scene_to_load):
	
	add_child(load(scene_to_load).instance()) ;
	var routeNode = get_child(get_child_count()-1) ;
	
	cur_route = routeNode ;
	cur_route_name = routeNode.my_route_dict["my_name"] ;
	cur_route_path = routeNode.my_route_dict["my_path"] ;
	
	playerPause.setPlayerController(routeNode.get_node("YSort/PlayerController")) ;
	$DialogueSystem.connectToNodes() ;
	$TitleScreen.queue_free() ;
	
	state = WORLD ;
	


func _input(event):
	
	if event.is_action_pressed("ui_cancel") and state == WORLD:
		if $PlayerMenu/CanvasLayer/CreaturePanel.visible == false:
			$PlayerMenu/CanvasLayer/CreaturePanel.visible = true ;
		elif $PlayerMenu/CanvasLayer/CreaturePanel/CreatureSlot.visible == true:
			$PlayerMenu/CanvasLayer/CreaturePanel/CreatureSlot.visible = false ;
			$PlayerMenu.resetPlayerMenu() ;
			$PlayerMenu/CanvasLayer/CreaturePanel/CreatureSelect.visible = true ;
		else:
			$PlayerMenu/CanvasLayer/CreaturePanel.visible = false ;
	
	

func change_state(my_state, routeScene, encounter, battleStage):
	match my_state:
		WORLD:
			world_state(routeScene) ;
		BATTLE:
			battle_state(encounter, battleStage) ;
		MENU:
			pass

func world_state(routeScene):
	#load the correct route scene data
	#need to defer this until the previous scene has been freed
	#otherwise it tries to do both simultaenously and locks up
	add_child(load(routeScene).instance());
	var routeNode = get_child(get_child_count()-1) ;
	routeHandler.LoadSceneData(routeNode) ;
	routeNode.LoadMyData() ;
	
	
	
	cur_route = routeNode ;
	cur_route_name = routeNode.my_route_dict["my_name"] ;
	cur_route_path = routeNode.my_route_dict["my_path"] ;
	
	#player camera is new current view
	routeNode.setPlayerCamera(true) ;
	
	#let pause player class who new controller in route is
	#really need to look at moving this object around as part of scenechanger
	playerPause.setPlayerController(routeNode.playerController) ;
	
	#connect dialogue system to new routes npcs
	$DialogueSystem.connectToNodes() ;
	
	$Player.setActive();

func battle_state(encounter, battleStage):
	battle_data = encounter ;
	print(battleStage)
	battle_background = battleStage ;
	add_child(load("res://Source/BattleScene/BattleScene.tscn").instance()) ;


func change_to_world_state(routeScene):
	
	
	if state == BATTLE:
		$BattleScene.queue_free() ;
		#not sure why, but this cant be deferred with queue_free()  or else it's slow to load
	elif state == WORLD:
		var routeNode = get_child(get_child_count()-1) ;
		routeNode.queue_free() ;
	
	state = WORLD ;
	#make sure previous scene has finished excution before loading new route
	call_deferred("change_state", state, routeScene, null, null);
	
func change_to_battle_state(encounter, battleStage):
	state = BATTLE ;
	
	if $PlayerMenu/CanvasLayer/CreaturePanel.visible == true:
			 $PlayerMenu/CanvasLayer/CreaturePanel.visible = false ;
			
	$Player.visible = true ;
	$Player.isActive = false ;
	
	player_pos = cur_route.playerController.position;
	player_frame = cur_route.playerController.animationTree.get("parameters/Idle/blend_position");
	player_z_index = cur_route.playerController.z_index ;
	
	var my_route_child = get_child(get_child_count()-1) ;
	routeHandler.SaveSceneData(my_route_child) ;
	my_route_child.queue_free() ;
	
	change_state(state, null, encounter, battleStage) ;
	
	
func IsEncounter(encounter, battleStage):
		change_to_battle_state(encounter, battleStage) ;


func changeRoute(new_route):
	var routeNode = get_child(get_child_count()-1) ;
	routeHandler.SaveSceneData(routeNode) ;
	change_to_world_state( routeHandler.getRoute(new_route) );
	

#func _on_screen_resized():
#	var new_window_size = OS.window_size
#
#	var scale_w = max(int(new_window_size.x / base_size.x), 1)
#	var scale_h = max(int(new_window_size.y / base_size.y), 1)
#	var scale = min(scale_w, scale_h)
#
#	var diff = new_window_size - (base_size * scale)
#	var diffhalf = (diff * 0.5).floor()
#
#	root.set_attach_to_screen_rect(Rect2(diffhalf, base_size * scale))
#
#	# Black bars to prevent flickering:
#	var odd_offset = Vector2(int(new_window_size.x) % 2, int(new_window_size.y) % 2)
#
#	VisualServer.black_bars_set_margins(
#		max(diffhalf.x, 0), # prevent negative values, they make the black bars go in the wrong direction.
#		max(diffhalf.y, 0),
#		max(diffhalf.x, 0) + odd_offset.x,
#		max(diffhalf.y, 0) + odd_offset.y
#	)
