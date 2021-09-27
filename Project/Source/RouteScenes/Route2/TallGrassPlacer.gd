extends TileMap


onready var tallGrass = load("res://Source/WorldObjects/TallGrass.tscn") ; 


func _ready():
	var usedCells = get_used_cells() ;
	
	
	for grassCell in usedCells.size():
		var tall_grass = tallGrass.instance() ;
		#converting from tile coordinate to screen pixel coordinate
		tall_grass.position.x = usedCells[grassCell][0] * 8 + 4;
		tall_grass.position.y = usedCells[grassCell][1] * 4 + 4;
		get_node("../YSort/Batch1").add_child(tall_grass) ;
		
