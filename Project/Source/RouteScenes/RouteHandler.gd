extends Node

var route_dict = {
	
	"Route1Scene": {
		"my_name": "Route1Scene",
		"my_path": "res://Source/RouteScenes/Route1/Route1Scene.tscn"
	},
	"Route2Scene": {
		"my_name": "Route2Scene",
		"my_path": "res://Source/RouteScenes/Route2/Route2Scene.tscn"
	},
} ;

func _ready():
	pass

func LoadSceneData(my_route_dict):
	my_route_dict = route_dict[my_route_dict["my_name"]] ;

func SaveSceneData(my_route_dict):
	route_dict[my_route_dict["my_name"]] = my_route_dict ;

func changeRoute(route_name):
	get_parent().change_to_world_state(route_dict.get(route_name, {}).get("my_path")) ;

func WriteSaveFile():
	pass

func ReadSaveFile():
	pass
