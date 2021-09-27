extends PopupPanel

onready var moveButton = "VBox/HBox/VBox2/MoveButton" ;
onready var switchButton = "VBox/HBox/VBox2/SwitchButton" ;
onready var itemButton = "VBox/HBox/VBox3/ItemButton" ;
onready var runButton = "VBox/HBox/VBox3/RunButton" ;

var menuSelection ;

func displayBattleMenu(moves, items, switch, run):
	#get_node(moveButton).set_text("Move") ;
	#get_node(switchButton).set_text("Switch") ;
	#get_node(itemButton).set_text("Item") ;
	#get_node(runButton).set_text("Run") ;
	
	get_node("VBox/HBox/VBox2/MoveButton").disabled = !moves ;
	get_node("VBox/HBox/VBox2/SwitchButton").disabled = !switch ;
	get_node("VBox/HBox/VBox3/ItemButton").disabled = !items ;
	get_node("VBox/HBox/VBox3/RunButton").disabled = !run ;
	
	get_node("VBox/HBox/VBox2/MoveButton").grab_focus() ;
	visible = true ;


func resetButtons():
	get_node(moveButton).disabled = true ;
	get_node(switchButton).disabled = true ;
	get_node(itemButton).disabled = true ;
	get_node(runButton).disabled = true ;
	menuSelection = null ;



func BattleMenuSelect(menuSelection):
	resetButtons() ;
	get_node("../BattleUIHandler").BattleMenuSelect(menuSelection) ;


func _on_MoveButton_pressed():
	menuSelection = "Move" ;
	BattleMenuSelect(menuSelection) ;


func _on_SwitchButton_pressed():
	menuSelection = "Switch" ;
	BattleMenuSelect(menuSelection) ;


func _on_ItemButton_pressed():
	menuSelection = "Item" ;
	BattleMenuSelect(menuSelection) ;


func _on_RunButton_pressed():
	menuSelection = "Run" ;
	BattleMenuSelect(menuSelection) ;
