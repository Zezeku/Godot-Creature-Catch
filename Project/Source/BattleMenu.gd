extends PopupPanel

onready var moveButton = "VBox/HBox/VBox2/MoveButton" ;
onready var switchButton = "VBox/HBox/VBox2/SwitchButton" ;
onready var itemButton = "VBox/HBox/VBox3/ItemButton" ;
onready var runButton = "VBox/HBox/VBox3/RunButton" ;

var menuSelection ;
signal menuSelect(menu) ;

func displayBattleMenu():
	#get_node(moveButton).set_text("Move") ;
	#get_node(switchButton).set_text("Switch") ;
	#get_node(itemButton).set_text("Item") ;
	#get_node(runButton).set_text("Run") ;
	
	get_node("VBox/HBox/VBox2/MoveButton").disabled = false ;
	#get_node("VBox/HBox/VBox2/SwitchButton").disabled = false ;
	get_node("VBox/HBox/VBox3/ItemButton").disabled = false ;
	get_node("VBox/HBox/VBox3/RunButton").disabled = false ;
	
	visible = true ;

	
	
	
func resetButtons():
	get_node(moveButton).disabled = true ;
	get_node(switchButton).disabled = true ;
	get_node(itemButton).disabled = true ;
	get_node(runButton).disabled = true ;





func _on_MoveButton_pressed():
	resetButtons()
	menuSelection = "Move" ;
	emit_signal("menuSelect", menuSelection) ;


func _on_SwitchButton_pressed():
	resetButtons()
	menuSelection = "Switch" ;
	emit_signal("menuSelect", menuSelection) ;


func _on_ItemButton_pressed():
	resetButtons()
	menuSelection = "Item" ;
	emit_signal("menuSelect", menuSelection) ;


func _on_RunButton_pressed():
	resetButtons()
	menuSelection = "Run" ;
	emit_signal("menuSelect", menuSelection) ;
