extends Node2D

onready var Party = $Party ;
onready var creatureX = load("res://Source/CreatureTemplates/CreatureX.tscn") ;
onready var rng = RandomNumberGenerator.new()

onready var battleTeam = [null, null] ;

var moveUse = [null,null] ;
var targetUse = [null,null] ;

func _ready():
	
	$Party.add_child(creatureX.instance()) ;
	
	rng.randomize() ;
	if rng.randf_range(0,1) <= 0.5:
		$Party.get_child(0).initializeStats(load("res://Source/CreatureTemplates/Creature System/Creature001.tres"),2) ;
	else:
		$Party.get_child(0).initializeStats(load("res://Source/CreatureTemplates/Creature System/Creature009.tres"),2) ;
	
	$Party.get_child(0).set_name($Party.get_child(0).creatureName) ;
	

func isMon2():
	return Party.get_child_count() > 1 ;
