extends YSort


const ENCOUNTER_RATE = 0.05;
var rng = RandomNumberGenerator.new() ;


onready var creatureX = load("res://Source/CreatureTemplates/CreatureX.tscn") ;
onready var Player = get_node("../../../Player") ;

export(Array, float) var encounterRate ;
export(Array, Array, Resource) var encounterCreature ;
export(Array, Array, int) var encounterLevel ;
#set encounters, then randomize between them

func IsEncounter():
	rng.randomize() ;
	var randomNumber = rng.randf_range(0, 1) ;
	if randomNumber <= ENCOUNTER_RATE and Player.isActive:
		#this is bad. look at throwing signal instead.
		get_parent().get_parent().get_parent().IsEncounter(Encounter()) ;

func Encounter():
	
	rng.randomize() ;
	var randomNumber = rng.randf_range(0,1);
	
	var encounter = [];
	
	for key in encounterRate.size():
		if randomNumber >= encounterRate[key]:
			print(randomNumber)
			print(encounterCreature[key])
			print(encounterLevel[key])
			for creature in encounterCreature[key].size():
				
				var enemy = encounterCreature[key][creature] ;
				var level = encounterLevel[key][creature] ;
				
				encounter.append(creatureX.instance()) ;
				encounter[creature].initializeStats(enemy, level) ;
				
			break ;

	return encounter ;
