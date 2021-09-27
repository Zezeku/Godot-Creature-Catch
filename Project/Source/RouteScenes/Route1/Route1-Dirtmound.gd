extends TileMap


onready var flower = load("res://Source/WorldObjects/Flower.tscn") ; 

var rng = RandomNumberGenerator.new() ;

func _ready():
	var usedCells = get_used_cells() ;
	
	for dirtCell in usedCells.size():
		rng.randomize() ;
		var new_flower = flower.instance() ;
		new_flower.frame = rng.randi_range(0,1) ;
		new_flower.position.x = usedCells[dirtCell][0] * 16  + 3 + rng.randi_range(-1,1)
		new_flower.position.y = usedCells[dirtCell][1] * 16  + 3 + rng.randi_range(-1,1)
		get_node("../../YSort/FlowerSort").add_child(new_flower) ;
		get_node("../../YSort/FlowerSort").get_child(get_node("../../YSort/FlowerSort").get_child_count()-1).animation = randomAnim();
		
		rng.randomize() ;
		new_flower = flower.instance() ;
		new_flower.frame = rng.randi_range(0,1) ;
		new_flower.position.x = usedCells[dirtCell][0] * 16 + 3 + rng.randi_range(-1,1)
		new_flower.position.y = usedCells[dirtCell][1] * 16 + 12 + rng.randi_range(-1,1)
		get_node("../../YSort/FlowerSort").add_child(new_flower) ;
		get_node("../../YSort/FlowerSort").get_child(get_node("../../YSort/FlowerSort").get_child_count()-1).animation = randomAnim();
		
		rng.randomize() ;
		new_flower = flower.instance() ;
		new_flower.frame = rng.randi_range(0,1) ;
		new_flower.position.x = usedCells[dirtCell][0] * 16 + 12 + rng.randi_range(-1,1)
		new_flower.position.y = usedCells[dirtCell][1] * 16 + 3 + rng.randi_range(-1,1)
		get_node("../../YSort/FlowerSort").add_child(new_flower) ;
		get_node("../../YSort/FlowerSort").get_child(get_node("../../YSort/FlowerSort").get_child_count()-1).animation = randomAnim();
		
		rng.randomize() ;
		new_flower = flower.instance() ;
		new_flower.frame = rng.randi_range(0,1) ;
		new_flower.position.x = usedCells[dirtCell][0] * 16 + 12 + rng.randi_range(-1,1)
		new_flower.position.y = usedCells[dirtCell][1] * 16 + 12 + rng.randi_range(-1,1)
		get_node("../../YSort/FlowerSort").add_child(new_flower) ;
		get_node("../../YSort/FlowerSort").get_child(get_node("../../YSort/FlowerSort").get_child_count()-1).animation = randomAnim();

func randomAnim():
	rng.randomize();
	var animation = ""
	
	if rng.randi_range(0,1) == 0 :
		animation = "RedFlower" ;
	else:
		animation = "BlueFlower" ;
	
	return animation ;
	
