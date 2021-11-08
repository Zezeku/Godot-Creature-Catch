extends Node2D

var hasKey = false ;
var hasVisionGloves = false ;
var currentFloorPuzzle = Vector2.ZERO ;


# Called when the node enters the scene tree for the first time.
func _ready():
	$AbyssDungeon/YSort/PlayerController.setSpeed(50) ;
# warning-ignore:return_value_discarded
	$AbyssDungeon/YSort/TreasureChests/TreasureChest.connect("isOpened",self,"FillFloor") ;
	
	for node in get_tree().get_nodes_in_group("FloorPuzzle"):
		node.connect("isStepped", self, "updateFloorPuzzle") ;
	
	for node in get_tree().get_nodes_in_group("VisionOrbs"):
		node.connect("isOn", self, "updateOrb") ;
	
	initializePlayerController() ;
	startPlayerController() ;

func initializePlayerController():
	$AbyssDungeon/YSort/PlayerController.setSpeed(50) ;
	$AbyssDungeon/YSort/PlayerController.set_physics_process(false) ;
	$AbyssDungeon/YSort/PlayerController/AnimationTree.active = false ;
	$AbyssDungeon/YSort/PlayerController/Sprite.frame = 7 ;
	
func startPlayerController():
	$AbyssDungeon/YSort/PlayerController.set_physics_process(true) ;
	
func updateFloorPuzzle(block, my_position):
	
	if currentFloorPuzzle == Vector2.ZERO or isValidBlock(my_position):
		block.flip() ;
		currentFloorPuzzle = my_position ;
	
	if isFloorPuzzleComplete():
		var floorTiles = $AbyssDungeon/AbyssDungeonClosedDoor ;
		floorTiles.set_cell(-44,-39,-1) ; #-1 tile index reserved for clearing out cell
		floorTiles.set_cell(-50,-39,7, -1) ;

func isValidBlock(my_position):
	
	var distance = currentFloorPuzzle - my_position ;
#	print("my_pos = ", my_position) ;
#	print("currentFloor = ", currentFloorPuzzle) ;
#	print("disntance = ", distance) ;
	
	if (abs(distance.x) == 16 and abs(distance.y) == 0) or (abs(distance.x) == 0 and abs(distance.y) == 16):
		return true ;
	else:
		return false ;
		
func isFloorPuzzleComplete():
	var complete = true ;
	for node in get_tree().get_nodes_in_group("FloorPuzzle"):
		if !node.isStepped:
			complete = false ;
			break ;
	
	return complete ;

func FillFloor():
	hasKey = true ;
	var floorTiles = $AbyssDungeon/AbyssDungeonFloor ;
	
	floorTiles.set_cell(-15,-33,7,false,false,true) ;
	floorTiles.set_cell(-14,-33,7,false,false,true) ;
	
	floorTiles.set_cell(-15,-32,0) ;
	floorTiles.set_cell(-14,-32,0) ;
	
	floorTiles.set_cell(-15,-31,5) ;
	floorTiles.set_cell(-14,-31,5) ;

func updateOrbPuzzle(orb):
	for child in $AbyssDungeon/YSort/VisionOrbPuzzle.get_children():
		var horizontal = abs(child.position.x - orb.position.x) == 32 and abs(child.position.y - orb.position.y) == 0 ;
		var vertical = abs(child.position.x - orb.position.x) == 0 and abs(child.position.y - orb.position.y) == 32 ;
		if horizontal or vertical:
			child.flip() ;
	
	if isOrbPuzzleComplete():
		var floorTiles = $AbyssDungeon/AbyssDungeonClosedDoor ;
		floorTiles.set_cell(29,-50,-1) ; #-1 tile index reserved for clearing out cell
		floorTiles.set_cell(29,-56,-1) ;
	
	else:
		var floorTiles = $AbyssDungeon/AbyssDungeonClosedDoor ;
		floorTiles.set_cell(29,-50,2) ; #-1 tile index reserved for clearing out cell
		floorTiles.set_cell(29,-56,3,false,false,true) ;

func isOrbPuzzleComplete():
	var complete = true ;
	for child in $AbyssDungeon/YSort/VisionOrbPuzzle.get_children():
		if !child.isOn:
			complete = false ;
			break ;
	
	return complete ;

func _on_Area2D_body_entered(body):
	if body.name == "PlayerController" and hasKey:
		var floorTiles = $AbyssDungeon/AbyssDungeonClosedDoor ;
		floorTiles.set_cell(-12,-39,-1) ; #-1 tile index reserved for clearing out cell
		floorTiles.set_cell(-18,-39, -1) ;
		
		$AbyssDungeon/AbyssDungeonFloor.set_cell(-1,-19,3)


func _on_TreasureChest2_isOpened():
	var floorTiles = $AbyssDungeon/AbyssDungeonClosedDoor ;
	floorTiles.set_cell(-44,-39,3,true) ; #-1 tile index reserved for clearing out cell
	floorTiles.set_cell(-50,-39, 3) ;
	
	$AbyssDungeon/YSort/VisionOrbs/VisionOrb9.flip() ;
	$AbyssDungeon/YSort/VisionOrbs/VisionOrb10.flip() ;
	
	hasVisionGloves = true ;

func updateOrb(orb):
	if hasVisionGloves:
		orb.flip() ;
		#checking first room orb
		if orb.name == "VisionOrb":
			checkVisionDoor1() ;
		#checking vision glove room
		if orb.name == "VisionOrb6" or orb.name == "VisionOrb7" or orb.name == "VisionOrb9" or orb.name == "VisionOrb10":
			checkVisionDoor2() ;
		#checking orb puzzle room
		if orb.get_parent().name == "VisionOrbPuzzle":
			updateOrbPuzzle(orb) ;

func checkVisionDoor1():
	var orb = $AbyssDungeon/YSort/VisionOrbs/VisionOrb
	var floorTiles = $AbyssDungeon/AbyssDungeonClosedDoor ;
	
	if orb.isOn:
		floorTiles.set_cell(12,-39,-1) ; #-1 tile index reserved for clearing out cell
		floorTiles.set_cell(18,-39, -1) ;
		$AbyssDungeon/AbyssDungeonFloor.set_cell(1,-19,3)
	else:
		floorTiles.set_cell(12,-39,3) ; #-1 tile index reserved for clearing out cell
		floorTiles.set_cell(18,-39,3, true) ;
		$AbyssDungeon/AbyssDungeonFloor.set_cell(1,-19,4)
	
func checkVisionDoor2():
	var visionOrb = $AbyssDungeon/YSort/VisionOrbs ;
	var v1 = visionOrb.get_node("VisionOrb6").isOn ;
	var v2 = visionOrb.get_node("VisionOrb7").isOn ;
	var v3 = visionOrb.get_node("VisionOrb9").isOn ;
	var v4 = visionOrb.get_node("VisionOrb10").isOn ;
	
	var floorTiles = $AbyssDungeon/AbyssDungeonClosedDoor ;
	
	if v1 and v2 and v3 and v4:
		floorTiles.set_cell(-44,-39,-1) ; #-1 tile index reserved for clearing out cell
		floorTiles.set_cell(-50,-39,7, -1) ;
	
	else:
		floorTiles.set_cell(-44,-39,3,true) ; #-1 tile index reserved for clearing out cell
		floorTiles.set_cell(-50,-39, 3) ;
