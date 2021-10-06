extends Node2D


onready var playerController = get_node("YSort/PlayerController");


onready var my_route_dict = {
	"my_name": "Route2Scene",
	"my_path": "res://Source/RouteScenes/Route2/Route2Scene.tscn",
	"my_respawn": Vector2(-89,77),
	"NPCX": $YSort/NPCX.itemGiven,
	"NPCX2": $YSort/NPCX2.itemGiven
} ;

func LoadMyData():
	
	playerController.position = my_route_dict["my_respawn"] ;
	$YSort/NPCX.itemGiven = my_route_dict["NPCX"] ;
	$YSort/NPCX2.itemGiven = my_route_dict["NPCX2"] ;

func setPlayerCamera(visible):
	get_node("YSort/PlayerController/PlayerCamera").current = visible ;


func _on_RouteChange_body_entered(body):
	if body.name == "PlayerController":
		get_parent().routeHandler.changeRespawn("Route1Scene", Vector2(730,-220)) ;
		get_parent().changeRoute("Route1Scene") ;


func _on_Stairs_Area_body_entered(body):
	if body.name == "PlayerController":
		$Hills.set_collision_layer_bit(0, false) ;
		$Hills.set_collision_mask_bit(0, false) ;
		$BeachFloor.set_collision_layer_bit(0, false) ;
		$BeachFloor.set_collision_mask_bit(0, false) ;


func _on_Stairs_Area_body_exited(body):
	if body.name == "PlayerController":
		$Hills.set_collision_layer_bit(0, true) ;
		$Hills.set_collision_mask_bit(0, true) ;
		$BeachFloor.set_collision_layer_bit(0, true) ;
		$BeachFloor.set_collision_mask_bit(0, true) ;
		
		if body.z_index == 1:
			body.z_index = 2 ;
		else:
			body.z_index = 1 ;


func _on_Bridge_Area_body_entered(body):
	if body.name == "PlayerController":
		if body.z_index == 2:
			$Bridges.z_index = 0 ;
			$BridgeBackRope.z_index = 0 ;
			
			$Hills.set_collision_layer_bit(0, false) ;
			$Hills.set_collision_mask_bit(0, false) ;
		else:
			$Bridges.set_collision_layer_bit(0, false) ;
			$Bridges.set_collision_mask_bit(0, false) ;


func _on_Bridge_Area_body_exited(body):
	if body.name == "PlayerController":
		if body.z_index == 2:
			$Bridges.z_index = 2 ;
			$BridgeBackRope.z_index = 2 ;
			
			$Hills.set_collision_layer_bit(0, true) ;
			$Hills.set_collision_mask_bit(0, true) ;
		else:
			$Bridges.set_collision_layer_bit(0, true) ;
			$Bridges.set_collision_mask_bit(0, true) ;
