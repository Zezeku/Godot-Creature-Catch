extends Node

class_name StateMachine

var state:Object
var history = []

func _ready():
	pass ;
	state = get_child(0).get_child(0) ; #set initial state to BattleStart
	_enter_state() ;

func _enter_state():
	state.enter(self) ;

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
	if event is InputEventMouseButton and state.has_method("inputEnter"):
		state.inputEnter() ;
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


func _on_BattleMenu_menuSelect(menu):
	if menu == "Run":
		state.inputRun() ;
	elif menu == "Move":
		state.inputMove() ;
	elif menu == "Item" :
		state.inputItem() ;
	elif menu == "Switch" :
		pass ;
		#state == inputSwitch() ;
	else:
		print("Invalid Command ") ;
