tool
extends TileMap


#onready var tallGrass = load("res://Source/WorldObjects/TallGrass.tscn") ; 
export(Resource) var tileSet ;
export(PackedScene) var tallGrass ;
export(Texture) var tallGrassTexture ;
export(NodePath) var batch_name ;
export(int) var tallGrassZIndex ;

func _process(delta):
	if Engine.editor_hint:
		tile_set = tileSet;

func _ready():
	
	var usedCells = get_used_cells() ;
	
	
	for grassCell in usedCells.size():
		var tall_grass = tallGrass.instance() ;
		tall_grass.z_index = tallGrassZIndex ;
		tall_grass.setTexture(tallGrassTexture) ;
		#converting from tile coordinate to screen pixel coordinate
		tall_grass.position.x = usedCells[grassCell][0] * 8 + 4;
		tall_grass.position.y = usedCells[grassCell][1] * 4 + 12;
		get_node(batch_name).add_child(tall_grass) ;
		
