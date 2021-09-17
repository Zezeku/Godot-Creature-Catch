extends Node2D


func _ready():
	$YSort/VillageGirl/DialougeArea.connect("healParty", self, "healParty") ;

#village girl panel visibility

func loadData(data):
	$YSort/VillageGirl/Panel2.visible = data[0] ;
	$YSort/VillageGirl/DialougeArea.itemGiven = data[1] ;
	$YSort/TrainerBattle/EncounterCheck.isBeaten = data[2] ;

func saveData():
	return [$YSort/VillageGirl/Panel2.visible,
	$YSort/VillageGirl/DialougeArea.itemGiven, 
	$YSort/TrainerBattle/EncounterCheck.isBeaten] ;
	

func resetData() :
	$YSort/VillageGirl/Panel2.visible = true ;
	$YSort/VillageGirl/DialougeArea.itemGiven = false ;
	$YSort/TrainerBattle/EncounterCheck.active = false ;

func healParty():
	get_node("../Player").healParty() ;
