extends Node


#these shortcuts get used by children. so must account for them being 1 layer down from state
onready var SceneHandler = get_node("../../../..") ;
onready var Player = get_node("../../../../Player") ;
onready var Inventory = get_node("../../../Player/Inventory") ;
onready var Enemy = get_node("../../../Enemy") ;
onready var Creature = get_node("../../../BaseCreature") ;


signal createEncounter ;
signal PlayBattleMusic ;
signal ShowBattleStart(player, enemy);

signal ShowPlayerUI(player_creature_1, player_creature_2) ;
signal ShowEnemyUI(enemy_creature_1, enemy_creature_) ;

signal DisplayBattleMenu(moves, items, switch, run) ;
signal DisplayItems(inv_dict) ;
signal DisplayMoves(moveList) ;
signal DisplayTargetUI;

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


func useItem(item_key, source, target):
	Inventory.useItem(item_key, source, target) ;

func CreateEncounter():
	emit_signal("createEncounter") ;

func PlayBattleMusic():
	emit_signal("PlayBattleMusic") ;

func ShowBattleStart(player, enemy):
	emit_signal("ShowBattleStart", player, enemy) ;

func ShowPlayerUI(player_creature_1, player_creature_2):
	emit_signal("ShowPlayerUI",player_creature_1, player_creature_2) ;

func ShowEnemyUI(enemy_creature_1, enemy_creature_2):
	emit_signal("ShowEnemyUI", enemy_creature_1, enemy_creature_2) ;

func DisplayBattleMenu(moves, switch, run):
	var items = (Inventory.inv_dict.size() > 0) ;
	emit_signal("DisplayBattleMenu", moves, items, switch, run) ;

func DisplayItems():
	emit_signal("DisplayItems", Inventory.inv_dict) ;

func DisplayMoves():
	emit_signal("DisplayMoves", activeChar.moveList) ;

func DisplayTargetUI():
	emit_signal("DisplayTargetUI") ;
