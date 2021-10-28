extends Node2D


onready var playerController = get_node("YSort/PlayerController");


onready var my_route_dict = {
	"my_name": name,
	"my_path": filename,
	"my_respawn": Vector2(-89,77),
	"my_z_index": 1, 
	"NPCX": $YSort/NPCX.itemGiven,
	"NPCX2": $YSort/NPCX2.itemGiven,
	"NPCX3": $YSort/NPCX3.itemGiven
} ;

func LoadMyData():
	playerController.position = my_route_dict["my_respawn"] ;
	playerController.z_index = my_route_dict["my_z_index"] ;
	$YSort/NPCX.itemGiven = my_route_dict["NPCX"] ;
	$YSort/NPCX2.itemGiven = my_route_dict["NPCX2"] ;
	$YSort/NPCX3.itemGiven = my_route_dict["NPCX3"] ;
	
	$Bridges.set_collision_layer_bit(0, false) ;
	$Bridges.set_collision_mask_bit(0, false) ;

func setPlayerCamera(visible):
	get_node("YSort/PlayerController/PlayerCamera").current = visible ;


func _on_RouteChange_body_entered(body):
	if body.name == "PlayerController":
		get_parent().routeHandler.changeRespawn("DungeonRoute", Vector2(184,24), 1) ;
		get_parent().changeRoute("DungeonRoute") ;


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
		

func _on_Stairs_Area_Down_body_exited(body):
	if body.name == "PlayerController":
		body.z_index = 1 ;


func _on_Stairs_Area_Up_body_exited(body):
	if body.name == "PlayerController":
		body.z_index = 2 ;


func _on_Bridge_Area_body_entered(body):
	if body.name == "PlayerController":
		if body.z_index == 2:
			$Bridges.z_index = 0 ;
			$BridgeBackRope.z_index = 0 ;
			$BridgeFrontRope.z_index = 3 ;
			
			$Hills.set_collision_layer_bit(0, false) ;
			$Hills.set_collision_mask_bit(0, false) ;
			$Bridges.set_collision_layer_bit(0, true) ;
			$Bridges.set_collision_mask_bit(0, true) ;
			


func _on_Bridge_Area_body_exited(body):
	if body.name == "PlayerController":
		if body.z_index == 2:
			$Bridges.z_index = 2 ;
			$BridgeBackRope.z_index = 3 ;
			$BridgeFrontRope.z_index = 2 ;
			
			$Hills.set_collision_layer_bit(0, true) ;
			$Hills.set_collision_mask_bit(0, true) ;
			$Bridges.set_collision_layer_bit(0, false) ;
			$Bridges.set_collision_mask_bit(0, false) ;






func _on_HealParty_body_entered(body):
	if body.name == "PlayerController":
		get_node("../Player").healParty() ;
