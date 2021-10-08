extends Area2D


var isBeaten = false ;

onready var creatureX = load("res://Source/CreatureTemplates/CreatureX.tscn") ;
onready var encounter1 = load("res://Source/CreatureTemplates/Creature System/Creature009.tres") ;
onready var encounter2 = load("res://Source/CreatureTemplates/Creature System/Creature006.tres") ;

func IsEncounter():
	get_node("../PanelContainer").visible = false ;
	get_parent().get_parent().get_parent().get_parent().isTrainer = true ;
	get_parent().get_parent().get_parent().get_parent().change_to_battle_state(Encounter()) ;
#
func Encounter():
	var encounter = [];
	encounter.append(creatureX.instance())
	encounter.append(creatureX.instance())
	
	encounter[0].initializeStats(encounter1,4) ;
	encounter[0].set_name(encounter[0].creatureName) ;
	encounter[1].initializeStats(encounter2,4) ;
	encounter[1].set_name(encounter[1].creatureName) ;
	return encounter ;


func _on_EncounterCheck_body_entered(body):
	if body.name =="PlayerController" and !isBeaten and get_parent().get_parent().get_parent().get_parent().get_node("Player/Party").get_child_count() != 0:
		get_node("../PanelContainer").visible = true ;
		
		var t = Timer.new() ;
		add_child(t) ;
		t.one_shot = true ;
		t.autostart = false ;
		t.wait_time = 1 ;
		t.start() ;
		yield(t, "timeout") ;
		remove_child(t) ;
		t.queue_free() ;
		
		IsEncounter() ;
