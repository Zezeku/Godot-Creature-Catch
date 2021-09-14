extends Node2D

onready var Party = $Party ;
onready var creatureX = load("res://Source/CreatureTemplates/CreatureX.tscn") ;
onready var rng = RandomNumberGenerator.new()

onready var battleTeam = [null, null] ;

var moveUse = [null,null] ;
var targetUse = [null,null] ;

func isMon2():
	return Party.get_child_count() > 1 ;

func createEncounter(encounter):
	print("Enemy_creatingEncounter") ;
	
	for creature in encounter.size():
		$Party.add_child(encounter[creature])
		$Party.get_child(creature).set_name($Party.get_child(creature).creatureName) ;

func _on_BattleStart_createEncounter():
	createEncounter(get_parent().get_parent().battle_data) ; # Enemy -> battleSCene -> scenehandler.battle_data <- batch.encounter_data
