extends Node2D



#village girl panel visibility

func loadData(data):
	$YSort/VillageGirl/Panel2.visible = data[0] ;
	

func saveData():
	return $YSort/VillageGirl/Panel2.visible ;
	

func resetData() :
	$YSort/VillageGirl/Panel2.visible = true ;
