extends Node2D

onready var Party = $Party ;
onready var creatureX = load("res://Source/CreatureTemplates/CreatureX.tscn") ;

var battleTeam = [null, null] ;
var moveUse = [null,null] ;
var itemUse = [null, null] ;
var targetUse = [null,null] ;

var isActive ; #this prevents instant battles
var isFainted = false ; #this prevents battle from having to care

func _ready():
	isActive = false ;
	setActive() ;
#	$Party.add_child(creatureX.instance()) ;
#	$Party.get_child(0).initializeStats(load("res://Source/CreatureTemplates/Creature System/Creature001.tres"),4) ;
#	$Party.get_child(0).set_name($Party.get_child(0).creatureName) ;
	
func resetParty():
	for creature in $Party.get_child_count():
		var cur_creature = $Party.get_child(creature) ;
		
		cur_creature.stat_mult = [1,1,1,1,1,1,1,1,1,1,1] ; 
		if cur_creature.resourceType.resourceName == "Rage":
			cur_creature.stat[cur_creature.STAT.RESOURCE] = 0 ;
		else:
			cur_creature.stat[cur_creature.STAT.RESOURCE] =  cur_creature.stat[cur_creature.STAT.MAX_RESOURCE];
	

func Fainted():
	
	for c in $Fainted.get_child_count():
		var creature = $Fainted.get_child(0)
		$Fainted.remove_child(creature) ;
		$Party.add_child(creature) ;
		
	healParty() ;
	isFainted = true ; #this gets reset in scenehandler once position reset

func healParty():
	for creature in $Party.get_child_count():
		$Party.get_child(creature).stat[1] = $Party.get_child(creature).stat[0] ;
		$Party.get_child(creature).stat[3] = $Party.get_child(creature).stat[2] ;

func setActive():
	var t = Timer.new() ;
	add_child(t) ;
	t.one_shot = true ;
	t.autostart = false ;
	t.wait_time = 2 ;
	t.start() ;
	yield(t, "timeout") ;
	isActive = true ;
