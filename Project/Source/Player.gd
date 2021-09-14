extends Node2D

onready var Party = $Party ;
onready var creatureX = load("res://Source/CreatureTemplates/CreatureX.tscn") ;

var battleTeam = [null, null] ;
var moveUse = [null,null] ;
var itemUse = [null, null] ;
var targetUse = [null,null] ;

func _ready():
	
	$Party.add_child(creatureX.instance()) ;
	$Party.get_child(0).initializeStats(load("res://Source/CreatureTemplates/Creature System/Creature001.tres"),4) ;
	$Party.get_child(0).set_name($Party.get_child(0).creatureName) ;
	

func healParty():
	for creature in $Party.get_child_count():
		$Party.get_child(creature).stat[1] = $Party.get_child(creature).stat[0] ;
		$Party.get_child(creature).stat[3] = $Party.get_child(creature).stat[2] ;
