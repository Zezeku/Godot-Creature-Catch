extends Node


#these shortcuts get used by children. so must account for them being 1 layer down from state
onready var SceneHandler = get_node("../../../..") ;
onready var Player = get_node("../../../../Player") ;
onready var Enemy = get_node("../../../Enemy") ;
onready var Creature = get_node("../../../BaseCreature") ;

signal DisplayMoves(moveList) ;
signal DisplayMenu(creature) ;

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


func _on_BattleMenu_menuSelect(menu):
	
	if activeChar == get_node("../../../Player").battleTeam[0] :
		if menu == "Move":
			$Creature1Phase.inputOne();
		elif menu == "Switch":
			pass
		elif menu == "Item":
			$Creature1Phase.inputThree();
		elif menu == "Run":
			$Creature1Phase.inputTwo();
		else:
			print("State: Inavlid Battle Menu Command")
	
	else:
		if menu == "Move":
			$Creature2Phase.inputOne();
		elif menu == "Switch":
			pass
		elif menu == "Item":
			$Creature2Phase.inputThree();
		elif menu == "Run":
			$Creature2Phase.inputTwo();
		else:
			print("State: Inavlid Battle Menu Command")
	
