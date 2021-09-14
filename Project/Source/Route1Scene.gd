extends Node2D


func _ready():
	$YSort/VillageGirl/DialougeArea.connect("healParty", self, "healParty") ;

#village girl panel visibility

func loadData(data):
	$YSort/VillageGirl/Panel2.visible = data[0] ;
	$YSort/VillageGirl/DialougeArea.itemGiven = data[1] ;

func saveData():
	return [$YSort/VillageGirl/Panel2.visible,$YSort/VillageGirl/DialougeArea.itemGiven] ;
	

func resetData() :
	$YSort/VillageGirl/Panel2.visible = true ;
	$YSort/VillageGirl/DialougeArea.itemGiven = false ;

func healParty():
	get_node("../Player").healParty() ;
