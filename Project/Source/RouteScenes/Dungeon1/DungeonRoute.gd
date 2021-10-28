extends Node2D


onready var playerController = get_node("YSort/PlayerController");


onready var my_route_dict = {
	"my_name": name, 
	"my_path": filename,
	"my_respawn": Vector2(0,0),
	"my_z_index": 1
} ;

func LoadMyData():
	playerController.position = my_route_dict["my_respawn"] ;
	playerController.z_index = my_route_dict["my_z_index"] ;
	

func setPlayerCamera(visible):
	get_node("YSort/PlayerController/PlayerCamera").current = visible ;


func _on_RouteChange1_body_entered(body):
	if body.name == "PlayerController":
		get_parent().routeHandler.changeRespawn("Route1Scene", Vector2(730,-220), 1) ;
		get_parent().changeRoute("Route1Scene") ;


func _on_RouteChange2_body_entered(body):
	if body.name == "PlayerController":
		get_parent().routeHandler.changeRespawn("Route2Scene", Vector2(190,-460), 2) ;
		get_parent().changeRoute("Route2Scene") ;
