extends Node

var route_dict = {
	
	"Route1Scene": {
		"my_name": "Route1Scene",
		"my_path": "res://Source/RouteScenes/Route1/Route1Scene.tscn",
		"my_respawn": Vector2(40,190)

	},
	
	"Route2Scene": {
		"my_name": "Route2Scene",
		"my_path": "res://Source/RouteScenes/Route2/Route2Scene.tscn",
		"my_respawn": Vector2(-89,77)
	}
} ;

func _ready():
	pass

func LoadSceneData(new_route):
	new_route.my_route_dict = route_dict[new_route.name].duplicate() ;

func SaveSceneData(old_route):
	route_dict[old_route.name] = old_route.my_route_dict.duplicate() ;

func getRoute(route_name):
	return route_dict.get(route_name, {}).get("my_path") ;

func changeRespawn(route_name, respawn_point):
	route_dict[route_name]["my_respawn"] = respawn_point ;



func WriteSaveFile():
	pass

func ReadSaveFile():
	pass

#initialize file()
