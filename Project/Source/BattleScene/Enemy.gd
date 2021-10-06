extends Node2D


onready var battleTeam = [null, null] ;
var moveUse = [null,null] ;
var targetUse = [null,null] ;

func _ready():
# warning-ignore:return_value_discarded
	get_node("../StateMachine/State").connect("createEncounter", self, "createEncounter") ;


func createEncounter():
	var encounter = get_parent().get_parent().battle_data ;
	for creature in encounter.size():
		$Party.add_child(encounter[creature])
		$Party.get_child(creature).set_name($Party.get_child(creature).creatureName) ;


func getPartySize():
	return $Party.get_child_count() ;

func getCreature(creature_index):
	return $Party.get_child(creature_index) ;
