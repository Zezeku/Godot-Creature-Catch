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

onready var types = ["Fire", "Rock", "Wind", "Wood", "Plant", "Water", "Stealth", "Neutral"];
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
	
	#ROCK
	typeChart[1][0] = EFFECTIVE ;#VS FIRE
	typeChart[1][1] = RESIST ;#VS ROCK
	typeChart[1][2] = EFFECTIVE ; #VS WIND
	typeChart[1][3] = NEUTRAL ;#VS WOOD
	typeChart[1][4] = NEUTRAL ;#VS PLANT
	typeChart[1][5] = NEUTRAL ;#VS WATER
	typeChart[1][6] = NEUTRAL ;#VS STEALTH
	typeChart[1][7] = NEUTRAL ; #VS NEUTRAL
	
	#WIND
	typeChart[2][0] = NEUTRAL ;#VS FIRE
	typeChart[2][1] = RESIST ;#VS ROCK
	typeChart[2][2] = NEUTRAL ; #VS WIND
	typeChart[2][3] = RESIST ;#VS WOOD
	typeChart[2][4] = NEUTRAL ;#VS PLANT
	typeChart[2][5] = NEUTRAL ;#VS WATER
	typeChart[2][6] = EFFECTIVE ;#VS STEALTH
	typeChart[2][7] = NEUTRAL ; #VS NEUTRAL
	
	#WOOD
	typeChart[3][0] = RESIST ; #VS FIRE
	typeChart[3][1] = NEUTRAL ; #VS ROCK
	typeChart[3][2] = EFFECTIVE ; #VS WIND
	typeChart[3][3] = NEUTRAL ; #VS WOOD
	typeChart[3][4] = RESIST ; #VS PLANT
	typeChart[3][5] = NEUTRAL ; #VS WATER
	typeChart[3][6] = NEUTRAL ; #VS STEALTH
	typeChart[3][7] = NEUTRAL ; #VS NEUTRAL
	
	#PLANT
	typeChart[4][0] = RESIST ; #VS FIRE
	typeChart[4][1] = EFFECTIVE ; #VS ROCK
	typeChart[4][2] = NEUTRAL ; #VS WIND
	typeChart[4][3] = EFFECTIVE ; #VS WOOD
	typeChart[4][4] = RESIST ; #VS PLANT
	typeChart[4][5] = NEUTRAL ; #VS WATER
	typeChart[4][6] = NEUTRAL ; #VS STEALTH
	typeChart[4][7] = NEUTRAL ; #VS NEUTRAL
	
	#WATER
	typeChart[5][0] = EFFECTIVE ; #VS FIRE
	typeChart[5][1] = EFFECTIVE ; #VS ROCK
	typeChart[5][2] = NEUTRAL ; #VS WIND
	typeChart[5][3] = NEUTRAL ; #VS WOOD
	typeChart[5][4] = RESIST ; #VS PLANT
	typeChart[5][5] = RESIST ; #VS WATER
	typeChart[5][6] = NEUTRAL ; #VS STEALTH
	typeChart[5][7] = NEUTRAL ; #VS NEUTRAL
	
	#STEALTH
	typeChart[6][0] = NEUTRAL ; #VS FIRE
	typeChart[6][1] = NEUTRAL ; #VS ROCK
	typeChart[6][2] = EFFECTIVE ; #VS WIND
	typeChart[6][3] = RESIST ; #VS WOOD
	typeChart[6][4] = NEUTRAL ; #VS PLANT
	typeChart[6][5] = NEUTRAL ; #VS WATER
	typeChart[6][6] = RESIST ; #VS STEALTH
	typeChart[6][7] = NEUTRAL ; #VS NEUTRAL
	
	#NEUTRAL
	typeChart[7][0] = NEUTRAL ; #VS FIRE
	typeChart[7][1] = NEUTRAL ; #VS ROCK
	typeChart[7][2] = NEUTRAL ; #VS WIND
	typeChart[7][3] = NEUTRAL ; #VS WOOD
	typeChart[7][4] = NEUTRAL ; #VS PLANT
	typeChart[7][5] = NEUTRAL ; #VS WATER
	typeChart[7][6] = NEUTRAL ; #VS STEALTH
	typeChart[7][7] = NEUTRAL ; #VS NEUTRAL
	
func getMatchUp(sourceType, targetType):
	
	
	
	#use types to get indicies
	if targetType.size() == 1:
		return float(typeChart[types.find(sourceType.elementName)][types.find(targetType.elementName)] / 3) ;
	else:
		var check1 = typeChart[types.find(sourceType.elementName)][types.find(targetType[0].elementName)] ;
		var check2 = typeChart[types.find(sourceType.elementName)][types.find(targetType[1].elementName)] ;
		
		return float(floor( ( check1*check2 + 1 )/3) / 3)
	
	
	














