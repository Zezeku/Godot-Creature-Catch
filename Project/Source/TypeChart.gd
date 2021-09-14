extends Node


enum {
	IMMUNE,
	EXTRA_RESIST,
	RESIST,
	NEUTRAL,
	EFFECTIVE,
	EXTRA_EFFECTIVE
}

onready var types = ["Fire", "Rock", "Flying", "Wood", "Plant", "Water", "Stealth"];
var typeChart = [] ;

func _ready():
	
	for t in types.size():
		typeChart.append([]) ;
		for y in types.size():
			typeChart[t].append(null) ;
	
	fillTypeChart();
	print(typeChart)

func fillTypeChart():
	typeChart[0][0] = IMMUNE ;
	#etc.
	

func getMatchUp(sourceType, targetType):
	
	#will need conditional for double type
	return typeChart[sourceType][targetType] ;
	
