extends "res://Source/RouteScenes/RouteHandler.gd"


onready var playerController = get_node("YSort/PlayerController");



var my_route_dict = {
	"my_name": "Route2Scene",
	"my_path": "res://Source/RouteScenes/Route2/Route2Scene.tscn"
} ;

func _ready():
	LoadSceneData(my_route_dict) ;
	
func setPlayerCamera(visible):
	get_node("YSort/PlayerController/PlayerCamera").current = visible ;


func _on_RouteChange_body_entered(body):
	if body.name == "PlayerController":
		SaveSceneData(my_route_dict) ;
		changeRoute("Route1Scene")
