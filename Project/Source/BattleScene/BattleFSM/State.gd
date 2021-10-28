extends Node


#these shortcuts get used by children. so must account for them being 1 layer down from state
#get a lot of warnings, anyway to simplify this?
#just copy paste into eahc child, easy and lets me know which child uses what

#I need to save player children to array
#so that i can swap battle order around but not persist to route world
#easy fix i believe, ignore for now

onready var SceneHandler = get_node("/root/SceneHandler") ;
onready var Player = get_node("/root/SceneHandler/Player") ;
onready var Enemy = get_node("/root/SceneHandler/BattleScene/Enemy") ;

onready var Inventory = get_node("/root/SceneHandler/Player/Inventory") ;

signal setBackground ;
signal createEncounter ;
signal PlayBattleMusic ;
signal ShowBattleStart(player, enemy);

signal ShowPlayerUI(player_creature_1, player_creature_2) ;
signal ShowEnemyUI(enemy_creature_1, enemy_creature_) ;

signal DisplayBattleMenu(moves, items, switch, run) ;
signal DisplayItems(inv_dict) ;
signal DisplayMoves(moveList) ;
signal DisplaySwitch(player) ;
signal DisplayTargetingUI(player1, player2, enemy1, enemy2);
signal ActivateTargetingUI(targets, target_select) ;
signal ActivatePlayerTargetingUI(creature) ;
signal DisplayResourceMenu(creature, target, move) ;

signal HideMoves ;
signal HideItems ;
signal HideSwitch ;
signal HideTargetUI ;
signal HideResourceMenu ;

signal UpdatePlayerUI_Switch(creature, index) ;
signal UpdateTargetUI_Switch(creature, index) ;

var runAttempt ;
var activeChar ;

var _fsm: StateMachine ;

#we are passing in the statemachine itself, since it has the transition functions and the input
func enter(fsm:StateMachine):
	_fsm = fsm


func change_state(next_state):
	_fsm._change_to(next_state) ;

func useItem(item_key, source, target):
	Inventory.useItem(item_key, source, target, self) ;

func SetBackground():
	emit_signal("setBackground") ;

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

func DisplaySwitch(player):
	emit_signal("DisplaySwitch", player) ;

func DisplayTargetUI(player1, player2, enemy1, enemy2):
	emit_signal("DisplayTargetingUI", player1, player2, enemy1, enemy2) ;

func ActivateTargetingUI(targets, target_select):
	emit_signal("ActivateTargetingUI",targets, target_select) ;

func ActivatePlayerTargetingUI(creature):
	emit_signal("ActivatePlayerTargetingUI", creature) ;

func DisplayResourceMenu(creature, target, move):
	emit_signal("DisplayResourceMenu", creature, target, move) ;
	
func HideMoves():
	emit_signal("HideMoves") ;

func HideItems():
	emit_signal("HideItems") ;

func HideSwitch():
	emit_signal("HideSwitch") ;

func HideTargetUI():
	emit_signal("HideTargetUI") ;

func HideResourceMenu():
	emit_signal("HideResourceMenu") ;

func UpdatePlayerUI_Switch(creature, index):
	emit_signal("UpdatePlayerUI_Switch", creature, index) ;

func UpdateTargetUI_Switch(creature, index):
	emit_signal("UpdateTargetUI_Switch", creature, index) ;
