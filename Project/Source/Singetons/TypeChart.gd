extends Node


#id consieder learning to pull from csv so that source file can be spreadhseet
#easier to read typings for balancing

enum {
	IMMUNE, #0
	EXTRA_RESIST,#1
	RESIST,#2
	NEUTRAL,#3
	EFFECTIVE,#4
	EXTRA_EFFECTIVE#5
}

onready var types = ["Fire", "Rock", "Wind", "Wood", "Plant", "Water", "Stealth", "Neutral", "Fae", "Storm", "Geometry"];
var typeChart = [] ;

func _ready():
	
	for t in types.size():
		typeChart.append([]) ;
		for y in types.size():
			typeChart[t].append(null) ;
	
	fillTypeChart();

func fillTypeChart():
	#FIRE
	typeChart[0][0] = RESIST ;#VS FIRE
	typeChart[0][1] = RESIST ;#VS ROCK
	typeChart[0][2] = NEUTRAL ; #VS WIND
	typeChart[0][3] = EFFECTIVE ;#VS WOOD
	typeChart[0][4] = EFFECTIVE ;#VS PLANT
	typeChart[0][5] = RESIST ;#VS WATER
	typeChart[0][6] = NEUTRAL ;#VS STEALTH
	typeChart[0][7] = NEUTRAL ; #VS NEUTRAL
	typeChart[0][8] = EFFECTIVE ; #VS FAE
	typeChart[0][9] = NEUTRAL ; #VS STORM
	typeChart[0][10] = NEUTRAL ; #VS GEOMETRY
	
	#ROCK
	typeChart[1][0] = EFFECTIVE ;#VS FIRE
	typeChart[1][1] = RESIST ;#VS ROCK
	typeChart[1][2] = EFFECTIVE ; #VS WIND
	typeChart[1][3] = NEUTRAL ;#VS WOOD
	typeChart[1][4] = NEUTRAL ;#VS PLANT
	typeChart[1][5] = NEUTRAL ;#VS WATER
	typeChart[1][6] = NEUTRAL ;#VS STEALTH
	typeChart[1][7] = NEUTRAL ; #VS NEUTRAL
	typeChart[1][8] = NEUTRAL ; #VS FAE
	typeChart[1][9] = EFFECTIVE ; #VS STORM
	typeChart[1][10] = RESIST ; #VS GEOMETRY
	
	#WIND
	typeChart[2][0] = NEUTRAL ;#VS FIRE
	typeChart[2][1] = RESIST ;#VS ROCK
	typeChart[2][2] = NEUTRAL ; #VS WIND
	typeChart[2][3] = RESIST ;#VS WOOD
	typeChart[2][4] = NEUTRAL ;#VS PLANT
	typeChart[2][5] = NEUTRAL ;#VS WATER
	typeChart[2][6] = EFFECTIVE ;#VS STEALTH
	typeChart[2][7] = NEUTRAL ; #VS NEUTRAL
	typeChart[2][8] = NEUTRAL ; #VS FAE
	typeChart[2][9] = RESIST ; #VS STORM
	typeChart[2][10] = NEUTRAL ; #VS GEOMETRY
	
	#WOOD
	typeChart[3][0] = RESIST ; #VS FIRE
	typeChart[3][1] = NEUTRAL ; #VS ROCK
	typeChart[3][2] = EFFECTIVE ; #VS WIND
	typeChart[3][3] = NEUTRAL ; #VS WOOD
	typeChart[3][4] = RESIST ; #VS PLANT
	typeChart[3][5] = NEUTRAL ; #VS WATER
	typeChart[3][6] = NEUTRAL ; #VS STEALTH
	typeChart[3][7] = NEUTRAL ; #VS NEUTRAL
	typeChart[3][8] = EFFECTIVE ; #VS FAE
	typeChart[3][9] = NEUTRAL ; #VS STORM
	typeChart[3][10] = NEUTRAL ; #VS GEOMETRY
	
	#PLANT
	typeChart[4][0] = RESIST ; #VS FIRE
	typeChart[4][1] = EFFECTIVE ; #VS ROCK
	typeChart[4][2] = NEUTRAL ; #VS WIND
	typeChart[4][3] = EFFECTIVE ; #VS WOOD
	typeChart[4][4] = RESIST ; #VS PLANT
	typeChart[4][5] = NEUTRAL ; #VS WATER
	typeChart[4][6] = NEUTRAL ; #VS STEALTH
	typeChart[4][7] = NEUTRAL ; #VS NEUTRAL
	typeChart[4][8] = RESIST ; #VS FAE
	typeChart[4][9] = NEUTRAL ; #VS STORM
	typeChart[4][10] = NEUTRAL ; #VS GEOMETRY
	
	#WATER
	typeChart[5][0] = EFFECTIVE ; #VS FIRE
	typeChart[5][1] = EFFECTIVE ; #VS ROCK
	typeChart[5][2] = NEUTRAL ; #VS WIND
	typeChart[5][3] = NEUTRAL ; #VS WOOD
	typeChart[5][4] = RESIST ; #VS PLANT
	typeChart[5][5] = RESIST ; #VS WATER
	typeChart[5][6] = NEUTRAL ; #VS STEALTH
	typeChart[5][7] = NEUTRAL ; #VS NEUTRAL
	typeChart[5][8] = NEUTRAL ; #VS FAE
	typeChart[5][9] = NEUTRAL ; #VS STORM
	typeChart[5][10] = NEUTRAL ; #VS GEOMETRY
	
	#STEALTH
	typeChart[6][0] = NEUTRAL ; #VS FIRE
	typeChart[6][1] = NEUTRAL ; #VS ROCK
	typeChart[6][2] = EFFECTIVE ; #VS WIND
	typeChart[6][3] = RESIST ; #VS WOOD
	typeChart[6][4] = NEUTRAL ; #VS PLANT
	typeChart[6][5] = NEUTRAL ; #VS WATER
	typeChart[6][6] = RESIST ; #VS STEALTH
	typeChart[6][7] = NEUTRAL ; #VS NEUTRAL
	typeChart[6][8] = RESIST ; #VS FAE
	typeChart[6][9] = NEUTRAL ; #VS STORM
	typeChart[6][10] = EFFECTIVE ; #VS GEOMETRY
	
	#NEUTRAL
	typeChart[7][0] = NEUTRAL ; #VS FIRE
	typeChart[7][1] = NEUTRAL ; #VS ROCK
	typeChart[7][2] = NEUTRAL ; #VS WIND
	typeChart[7][3] = NEUTRAL ; #VS WOOD
	typeChart[7][4] = NEUTRAL ; #VS PLANT
	typeChart[7][5] = NEUTRAL ; #VS WATER
	typeChart[7][6] = NEUTRAL ; #VS STEALTH
	typeChart[7][7] = NEUTRAL ; #VS NEUTRAL
	typeChart[7][8] = NEUTRAL ; #VS FAE
	typeChart[7][9] = NEUTRAL ; #VS STORM
	typeChart[7][10] = EFFECTIVE ; #VS GEOMETRY
	
	#FAE
	typeChart[8][0] = RESIST ; #VS FIRE
	typeChart[8][1] = NEUTRAL ; #VS ROCK
	typeChart[8][2] = NEUTRAL ; #VS WIND
	typeChart[8][3] = RESIST ; #VS WOOD
	typeChart[8][4] = RESIST ; #VS PLANT
	typeChart[8][5] = NEUTRAL ; #VS WATER
	typeChart[8][6] = EFFECTIVE ; #VS STEALTH
	typeChart[8][7] = NEUTRAL ; #VS NEUTRAL
	typeChart[8][8] = NEUTRAL ; #VS FAE
	typeChart[8][9] = NEUTRAL ; #VS STORM
	typeChart[8][10] = EFFECTIVE ; #VS GEOMETRY
	
	#STORM
	typeChart[9][0] = NEUTRAL ; #VS FIRE
	typeChart[9][1] = RESIST ; #VS ROCK
	typeChart[9][2] = EFFECTIVE ; #VS WIND
	typeChart[9][3] = RESIST ; #VS WOOD
	typeChart[9][4] = RESIST ; #VS PLANT
	typeChart[9][5] = EFFECTIVE ; #VS WATER
	typeChart[9][6] = EFFECTIVE ; #VS STEALTH
	typeChart[9][7] = NEUTRAL ; #VS NEUTRAL
	typeChart[9][8] = NEUTRAL ; #VS FAE
	typeChart[9][9] = RESIST ; #VS STORM
	typeChart[9][10] = RESIST ; #VS GEOMETRY
	
	#GEOMETRY
	typeChart[10][0] = NEUTRAL ; #VS FIRE
	typeChart[10][1] = EFFECTIVE ; #VS ROCK
	typeChart[10][2] = NEUTRAL ; #VS WIND
	typeChart[10][3] = EFFECTIVE ; #VS WOOD
	typeChart[10][4] = RESIST ; #VS PLANT
	typeChart[10][5] = NEUTRAL ; #VS WATER
	typeChart[10][6] = RESIST ; #VS STEALTH
	typeChart[10][7] = NEUTRAL ; #VS NEUTRAL
	typeChart[10][8] = RESIST ; #VS FAE
	typeChart[10][9] = EFFECTIVE ; #VS STORM
	typeChart[10][10] = NEUTRAL ; #VS GEOMETRY
	
func getMatchUp(sourceType, targetType):
	
#	print("sourceType --- ", sourceType.elementName) ;
	#use types to get indicies
	if targetType.size() == 1:
#		print("targetType --- ", targetType[0].elementName)
#		print("type index --- ", types.find(targetType[0].elementName) )
		return float(float(typeChart[types.find(sourceType.elementName)][types.find(targetType[0].elementName)]) / 3) ;
		
		
	else:
#		print("targetType 1 --- ", targetType[0].elementName)
#		print("type index 1 --- ", types.find(targetType[0].elementName) )
#		print("targetType 2 --- ", targetType[1].elementName)
#		print("type index 2 --- ", types.find(targetType[1].elementName) )
		
		var check1 = typeChart[types.find(sourceType.elementName)][types.find(targetType[0].elementName)] ;
		var check2 = typeChart[types.find(sourceType.elementName)][types.find(targetType[1].elementName)] ;
		
		return float(floor( float(( check1*check2 + 1 ))/3) / 3)
	
	
	














