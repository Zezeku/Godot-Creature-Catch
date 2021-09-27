extends Node

#onready var root = get_tree().root
#onready var base_size = root.get_visible_rect().size

onready var playerPause = load("res://Source/Player/PlayerPause.gd").new() ;
var routeHandler ;
var cur_route = null ;
var battle_data = [] ;


enum{ 
	WORLD, 
	MENU, 
	BATTLE
	} ;

var state = null ;
var player_pos = Vector2.ZERO;
var player_frame = 0;

func _ready():
#	get_tree().connect("screen_resized", self, "_on_screen_resized")
	
#	root.set_attach_to_screen_rect(root.get_visible_rect())
#	_on_screen_resized()
	add_child(load("res://Source/Player/Player.tscn").instance()) ;
	add_child(load("res://Source/Player/PlayerMenu.tscn").instance()) ;
	add_child(load("res://Source/NPCs/DialogueSystem.tscn").instance()) ;
	routeHandler = load("res://Source/RouteScenes/RouteHandler.gd").new() ;
	
	add_child(load("res://Source/TitleScreen/TitleScreen.tscn").instance()) ;
	$TitleScreen.connect("loadScene", self, "LoadScene") ;
	

func LoadScene(scene_to_load):
	
	add_child(load(scene_to_load).instance()) ;
	cur_route = scene_to_load ;
	var routeNode = get_child(get_child_count()-1)
	playerPause.setPlayerController(routeNode.get_node("YSort/PlayerController")) ;
	$DialogueSystem.connectToNodes() ;
	$TitleScreen.queue_free() ;
	
	state = WORLD ;
	


func _input(event):
	
	if event.is_action_pressed("ui_cancel") and state == WORLD:
		if $PlayerMenu/CanvasLayer/CreaturePanel.visible == false:
			 $PlayerMenu/CanvasLayer/CreaturePanel.visible = true ;
		else:
			$PlayerMenu/CanvasLayer/CreaturePanel.visible = false ;
	
	

func change_state(my_state, routeScene, encounter):
	match my_state:
		WORLD:
			world_state(routeScene) ;
		BATTLE:
			battle_state(encounter) ;
		MENU:
			pass

func world_state(routeScene):
	#load the correct route scene data
	#need to defer this until the previous scene has been freed
	#otherwise it tries to do both simultaenously and locks up
	var routeNode = get_child(get_child_count()-1) ;
	#player camera is new current view
	routeNode.setPlayerCamera(true) ;
	
	#let pause player class who new controller in route is
	playerPause.setPlayerController(routeNode.playerController) ;
	
	#connect dialogue system to new routes npcs
	$DialogueSystem.connectToNodes() ;
	
	
	if !$Player.isFainted:
		routeNode.playerController.position = player_pos ;
		routeNode.playerController.animationTree.set("parameters/Idle/blend_position", player_frame);
	else:
		#this position should come from route data - respawn point
		routeNode.playerController.position = Vector2(2*16+8,12*16) ;
		$Player.isFainted = false ;
	
	if $Player/Party.get_child_count() > 0:
		$PlayerMenu.updatePlayerMenu($Player/Party.get_child(0)) ;
	
	$Player.setActive();
	
	

func battle_state(encounter):
	battle_data = encounter ;
	add_child(load("res://Source/BattleScene/BattleScene.tscn").instance()) ;


func change_to_world_state(routeScene):
	var newRoute = load(routeScene).instance() ;
	
	if state == BATTLE:
		$Player.visible = false ;
		#may need to store and rmeove child first?
		$BattleScene.queue_free() ;
		#not sure why, but this cant be deferred or else it does add fast enough, and later 
		#inits cant find node
		#might be realted to player controllers
		add_child(newRoute) ;
		
	elif state == WORLD:
		#make current route invisble and turn off camera and player controller
		var routeNode = get_child(get_child_count()-1) ;
		#may need to store and rmeove child first?
		routeNode.queue_free() ;
		cur_route = routeScene ;
		call_deferred("add_child", newRoute) ;
	
	state = WORLD ;
	change_state(state, routeScene, null) ;
	
func change_to_battle_state(encounter):
	state = BATTLE ;
	
	if $PlayerMenu/CanvasLayer/CreaturePanel.visible == true:
			 $PlayerMenu/CanvasLayer/CreaturePanel.visible = false ;
			
	$Player.visible = true ;
	$Player.isActive = false ;
	
	player_pos = $Route2Scene/YSort/PlayerController.position;
	player_frame = $Route2Scene/YSort/PlayerController.animationTree.get("parameters/Idle/blend_position");
	
	var my_route_child = $Route2Scene ;
	remove_child(my_route_child) ;
	my_route_child.queue_free() ;
	
	change_state(state, null, encounter) ;
	
	
func IsEncounter(encounter):
	
	if $Player.isActive:
		change_to_battle_state(encounter) ;
	else:
		pass
	
	

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
