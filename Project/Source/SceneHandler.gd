extends Node

onready var root = get_tree().root
onready var base_size = root.get_visible_rect().size

var scene_data ;
var isTrainer = false ;
var battle_data = [] ;


enum{ 
	WORLD, 
	MENU, 
	BATTLE
	} ;

var state = WORLD ;
var player_pos ;
var player_frame ;

func _ready():
	get_tree().connect("screen_resized", self, "_on_screen_resized")
	
	root.set_attach_to_screen_rect(root.get_visible_rect())
	_on_screen_resized()
	
	add_child(load("res://Source/Player.tscn").instance()) ;
	add_child(load("res://Source/Route1Scene.tscn").instance()) ;
	
	$Route1Scene/YSort/PlayerController.position = Vector2(2*16+8,12*16) ;

func change_state(my_state, encounter):
	match my_state:
		WORLD:
			world_state() ;
		BATTLE:
			battle_state(encounter) ;
		MENU:
			pass

func world_state():
	add_child(load("res://Source/Route1Scene.tscn").instance()) ;
	$Route1Scene/YSort/PlayerController/PlayerCamera.current = true ;
	move_child($Route1Scene, 0);
	
	$Route1Scene.loadData(scene_data) ;
	scene_data = null ; 
	
	if !$Player.isFainted:
		$Route1Scene/YSort/PlayerController.transform = player_pos ;
		$Route1Scene/YSort/PlayerController.animationTree.set("parameters/Idle/blend_position", player_frame);
	else:
		#this position should come from route data - respawn point
		$Route1Scene/YSort/PlayerController.position = Vector2(2*16+8,12*16) ;
		$Player.isFainted = false ;
	
	$Player.setActive();
	
	

func battle_state(encounter):
	battle_data = encounter ;
	add_child(load("res://Source/BattleScene.tscn").instance()) ;
	$BattleScene/Camera2D.current = true ;
	move_child($BattleScene, 0);


func change_to_world_state():
	
	state = WORLD ;
	
	$Player.visible = false ;
	$BattleScene.queue_free() ;
	isTrainer = false ; #battle ending so reseting this
	change_state(state, null) ;
	
func change_to_battle_state(encounter):
	state = BATTLE ;
	
	scene_data = $Route1Scene.saveData() ;
	$Player.visible = true ;
	$Player.isActive = false ;
	
	player_pos = $Route1Scene/YSort/PlayerController.transform ;
	player_frame = $Route1Scene/YSort/PlayerController.animationTree.get("parameters/Idle/blend_position");
	
	
	$Route1Scene.queue_free() ;
	change_state(state, encounter) ;
	
	

func _on_screen_resized():
	var new_window_size = OS.window_size
	
	var scale_w = max(int(new_window_size.x / base_size.x), 1)
	var scale_h = max(int(new_window_size.y / base_size.y), 1)
	var scale = min(scale_w, scale_h)
	
	var diff = new_window_size - (base_size * scale)
	var diffhalf = (diff * 0.5).floor()
	
	root.set_attach_to_screen_rect(Rect2(diffhalf, base_size * scale))
	
	# Black bars to prevent flickering:
	var odd_offset = Vector2(int(new_window_size.x) % 2, int(new_window_size.y) % 2)
	
	VisualServer.black_bars_set_margins(
		max(diffhalf.x, 0), # prevent negative values, they make the black bars go in the wrong direction.
		max(diffhalf.y, 0),
		max(diffhalf.x, 0) + odd_offset.x,
		max(diffhalf.y, 0) + odd_offset.y
	)
