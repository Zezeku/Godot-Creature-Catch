extends Node2D

onready var Party = $Party ;
onready var creatureX = load("res://Source/CreatureTemplates/CreatureX.tscn") ;

var battleTeam = [null, null] ;
var moveUse = [null,null] ;
var itemUse = [null, null] ;
var targetUse = [null,null] ;
var switchUse = [null, null] ;

var isActive ; #this prevents instant battles
var isFainted = false ; #this prevents battle from having to care

signal updateCreatureSlot(creature) ;

func _ready():
	isActive = false ;
	setActive() ;

func resetParty():
	for creature in $Party.get_child_count():
		var cur_creature = $Party.get_child(creature) ;
		
		cur_creature.stat_mult = [1,1,1,1,1,1,1,1,1,1,1] ; 
		if cur_creature.resourceType.resourceName == "Rage":
			cur_creature.stat[cur_creature.STAT.RESOURCE] = 0 ;
		else:
			cur_creature.stat[cur_creature.STAT.RESOURCE] =  cur_creature.stat[cur_creature.STAT.MAX_RESOURCE];
	

func getPartySize():
	return $Party.get_child_count() ;

func getCreature(creature_index):
	if $Party.get_child_count() > 0:
		return $Party.get_child(creature_index) ;

func getCaughtQueue():
	return $CaughtQueue ;

func resolveCaughtQueue():
	for child in $CaughtQueue.get_children():
		if $Party.get_child_count() < 6:
			$CaughtQueue.remove_child(child) ;
			$Party.add_child(child) ;
			emit_signal("updateCreatureSlot", child) ;
		else:
			print("no more room!")
			child.queue_free() ;

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
	
	resetParty() ;

func setActive():
	var t = Timer.new() ;
	add_child(t) ;
	t.one_shot = true ;
	t.autostart = false ;
	t.wait_time = 2 ;
	t.start() ;
	yield(t, "timeout") ;
	remove_child(t) ;
	t.queue_free() ;
	isActive = true ;

func resolveEffects():
	for creature in $Party.get_children():
		creature.resolveEffects() ;
