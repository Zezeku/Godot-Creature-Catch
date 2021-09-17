extends Node


#these shortcuts get used by children. so must account for them being 1 layer down from state
onready var SceneHandler = get_node("../../../..") ;
onready var Player = get_node("../../../../Player") ;
onready var Inventory = get_node("../../../Player/Inventory") ;
onready var Enemy = get_node("../../../Enemy") ;
onready var Creature = get_node("../../../BaseCreature") ;

signal DisplayMoves(moveList) ;
signal DisplayMenu(creature) ;
signal DisplayItems(items, items_amount) ;
signal hideDisplayMoves ;
signal hideDisplayItems ;

var runAttempt ;
var activeChar ;

var _fsm: StateMachine ;

#we are passing in the statemachine itself, since it has the transition functions and the input
func enter(fsm:StateMachine):
	_fsm = fsm


func change_state(next_state):
	_fsm._change_to(next_state) ;

#from here, we right functions that correspond to functions in state machine input
#state is the "master state" so hold any functionality that is common between all states
#my plan of attack is usually start with more, and generalize later

func displayBattleMenu():
	emit_signal("DisplayMenu", activeChar) ;
	

func displayMoves() :
	emit_signal("DisplayMoves", activeChar.moveList) ;

func displayItems():
	emit_signal("DisplayItems", Inventory.inventory, Inventory.inventory_amount) ;

func hideDisplayMoves():
	emit_signal("hideDisplayMoves") ;
	

func hideItemMenu():
	emit_signal("hideDisplayItems") ;

func _on_ItemMenu_itemSelected(itemSelect):
	get_node("../../../Player").itemUse[activeChar.get_index()] = 0 ;
	$ItemState.decide_next_state() ;
