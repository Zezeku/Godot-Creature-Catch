extends YSort


const ENCOUNTER_RATE = 0.05;
var rng = RandomNumberGenerator.new() ;

onready var player = get_node("../../../Player") ;

onready var creatureX = load("res://Source/CreatureTemplates/CreatureX.tscn") ;
onready var encounter1 = load("res://Source/CreatureTemplates/Creature System/Creature001.tres") ;
onready var encounter2 = load("res://Source/CreatureTemplates/Creature System/Creature006.tres") ;
onready var encounter3 = load("res://Source/CreatureTemplates/Creature System/Creature016.tres") ;

#set encounters, then randomize between them

func IsEncounter():
	rng.randomize() ;
	var randomNumber = rng.randf_range(0, 1) ;
	if randomNumber <= ENCOUNTER_RATE and player.isActive:
		get_parent().get_parent().get_parent().change_to_battle_state(Encounter()) ;

func Encounter():
	
	rng.randomize() ;
	var randomNumber = rng.randf_range(0,1);
	var encounter = [];
	
	if randomNumber <= 0.33:
		encounter.append(creatureX.instance()) ;
		encounter[0].initializeStats(encounter1,2) ;
	elif randomNumber <= 0.66:
		encounter.append(creatureX.instance()) ;
		encounter[0].initializeStats(encounter2,2) ;
	else:
		encounter.append(creatureX.instance()) ;
		encounter[0].initializeStats(encounter3,2) ;
	
	return encounter ;
