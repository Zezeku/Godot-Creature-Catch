extends PopupMenu

onready var creatureXButton = load("res://Source/BattleScene/BattleUI/CreatureButtonX.tscn") ;

func DisplaySwitch(Player):
	
	
	var player_party_array = Player.get_node("Party").get_children() ;
	var player_fainted_array = Player.get_node("Fainted").get_children() ;
	
	for child in player_party_array.size():
		var newCreatureXButton = creatureXButton.instance() ; 
		$VBox.add_child(newCreatureXButton) ;
		newCreatureXButton.creatureX = player_party_array[child] ;
		newCreatureXButton.initSwitchButton() ;
		#cant swap into current creature or creature already to swap in for slot 1
		if player_party_array[child] == Player.switchUse[0] or \
		player_party_array[child] == Player.battleTeam[0] or \
		player_party_array[child] == Player.battleTeam[1]:
			newCreatureXButton.disabled = true ;
	
	for child in player_fainted_array.size():
		var newCreatureXButton = creatureXButton.instance() ; 
		$VBox.add_child(newCreatureXButton) ;
		newCreatureXButton.creatureX = player_fainted_array[child] ;
		newCreatureXButton.initSwitchButton() ;
		newCreatureXButton.disabled = true ;
	
	
	for child in $VBox.get_children():
		child.connect("switch_pressed", self, "switch_pressed") ;
	$VBox.get_child(0).grab_focus() ;
	visible = true ;

func switch_pressed(creatureX):
	resetButtons() ;
	get_node("../BattleUIHandler").SwitchSelect(creatureX) ;

func resetButtons():
	for child in $VBox.get_child_count():
		var my_child = $VBox.get_child(0) ;
		$VBox.remove_child(my_child) ;
		my_child.queue_free() ;
	
	visible = false ;
