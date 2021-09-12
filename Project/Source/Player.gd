extends Node2D

onready var Party = $Party ;
onready var creatureX = load("res://Source/CreatureTemplates/CreatureX.tscn") ;

var battleTeam = [null, null] ;
var moveUse = [null,null] ;
var targetUse = [null,null] ;

func _ready():
	
	$Party.add_child(creatureX.instance()) ;
	$Party.get_child(0).initializeStats(load("res://Source/CreatureTemplates/Creature System/Creature001.tres"),4) ;
	$Party.get_child(0).set_name($Party.get_child(0).creatureName) ;
	
	
