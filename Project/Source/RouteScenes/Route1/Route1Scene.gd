extends Node2D

onready var playerController = get_node("YSort/PlayerController");

var my_route_dict = {
	"my_name": "Route2Scene",
	"my_path": "res://Source/RouteScenes/Route2/Route2Scene.tscn",
	"my_respawn": Vector2(40,190)
} ;

func LoadMyData():
	playerController.position = my_route_dict["my_respawn"] ;
	

func setPlayerCamera(visible):
	get_node("YSort/PlayerController/PlayerCamera").current = visible ;

func _on_RouteChange_body_entered(body):
		if body.name == "PlayerController":
			get_parent().routeHandler.changeRespawn("Route2Scene", Vector2(190,-460)) ;
			get_parent().changeRoute("Route2Scene") ;


#village girl panel visibility

#func loadData(data):
#	$YSort/VillageGirl/Panel2.visible = data[0] ;
#	$YSort/VillageGirl/DialougeArea.itemGiven = data[1] ;
#	$YSort/TrainerBattle/EncounterCheck.isBeaten = data[2] ;

#func saveData():
#	return [$YSort/VillageGirl/Panel2.visible,
#	$YSort/VillageGirl/DialougeArea.itemGiven, 
#	$YSort/TrainerBattle/EncounterCheck.isBeaten] ;
	

#func resetData() :
#	$YSort/VillageGirl/Panel2.visible = true ;
#	$YSort/VillageGirl/DialougeArea.itemGiven = false ;
#	$YSort/TrainerBattle/EncounterCheck.active = false ;

#func healParty():
#	get_node("../Player").healParty() ;



