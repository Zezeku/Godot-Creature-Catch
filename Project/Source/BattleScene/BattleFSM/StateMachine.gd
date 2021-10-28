extends Node

class_name StateMachine

var state:Object
var history = []

func _ready():
	
	state = get_child(0).get_child(0) ; #set initial state to BattleStart, which inherits State
	_enter_state() ; #this is what begins FSM execution, if we need to delay it, we do it by delaying this line

func _enter_state():
	state.enter(self) ; #pass statemahine into state. wil luse State to get access to change_to and previous state functions

func _change_to(new_state):
	history.append(state.name) ;
	state = state.get_parent().get_node(new_state) ;
	_enter_state();

func previous_state():
	if history.size() > 0 :
		state = state.get_parent().get_node(history.pop_back())
		_enter_state()

########## INPUT SCHEME ##################
func _input(event):
	if event.is_action_pressed("ui_accept") and state.has_method("inputEnter"):
		state.inputEnter() ;
	if event.is_action_pressed("1") and state.has_method("inputOne"):
		state.inputOne() ;
	if event.is_action_pressed("2") and state.has_method("inputTwo"):
		state.inputTwo() ;
	if event.is_action_pressed("3") and state.has_method("inputThree"):
		state.inputThree() ;
	if event.is_action_pressed("ui_cancel") and state.has_method("inputCancel"):
		state.inputCancel() ;


func _on_BattleUIHandler_FinishBattleStart():
	state.inputBattleStart() ;

func _on_BattleUIHandler_BattleMenuSelect(menuSelection):
	if menuSelection == "Run":
		state.inputRun() ;
	elif menuSelection == "Move":
		state.inputMove() ;
	elif menuSelection == "Item" :
		state.inputItem() ;
	elif menuSelection == "Switch" :
		state.inputSwitch() ;
	else:
		print("Invalid Command ") ;


func _on_BattleUIHandler_ItemSelect(item_key):
	state.inputItemSelect(item_key) ;

func _on_BattleUIHandler_MoveSelect(moveSelection):
	state.inputMoveSelect(moveSelection) ;

func _on_BattleUIHandler_TargetSelect(targetSelect):
	state.inputTargetSelect(targetSelect) ;


func _on_BattleUIHandler_SwitchSelect(creatureSelection):
	state.inputSwitchSelect(creatureSelection) ;


func _on_BattleUIHandler_AetherDistribute():
	state.AetherDistribute() ;
