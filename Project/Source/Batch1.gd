extends YSort


const ENCOUNTER_RATE = 0.05;
var rng = RandomNumberGenerator.new() ;
onready var creatureX = load("res://Source/CreatureTemplates/CreatureX.tscn") ;
onready var encounter1 = load("res://Source/CreatureTemplates/Creature System/Creature001.tres") ;
onready var encounter2 = load("res://Source/CreatureTemplates/Creature System/Creature009.tres") ;

#set encounters, then randomize between them

func IsEncounter():

	rng.randomize() ;
	var randomNumber = rng.randf_range(0, 1) ;
	if randomNumber <= ENCOUNTER_RATE:
		get_parent().get_parent().get_parent().change_to_battle_state(Encounter()) ;

func Encounter():
	
	rng.randomize() ;
	var randomNumber = rng.randf_range(0,1);
	var encounter = [];
	
	if randomNumber <= 0.45:
		encounter.append(creatureX.instance()) ;
		encounter[0].initializeStats(encounter1,2) ;
	elif randomNumber <= 0.9:
		encounter.append(creatureX.instance()) ;
		encounter[0].initializeStats(encounter2,2) ;
	else:
		encounter.append(creatureX.instance()) ;
		encounter[0].initializeStats(encounter1,2) ;
		encounter.append(creatureX.instance()) ;
		encounter[1].initializeStats(encounter2,2) ;
	
	print(encounter) ;
	return encounter ;
