extends Control



func displayPlayerUI(player1, player2):
	
	if player1 != null:
		get_node("HBox/Creature1UI").visible = true ;
		get_node("HBox/Creature1UI/VBox/NameLabel").text = player1.creatureName ;
		get_node("HBox/Creature1UI/VBox/LevelLabel").text = "Level:" + String(player1.level) ;
		get_node("HBox/Creature1UI/VBox/HPLabel").text = "HP:" + String(player1.stat[1]) + " / " + String(player1.stat[0]) ;
		get_node("HBox/Creature1UI/VBox/EXPLabel").text = "EXP:" + String(player1.experience) + " / " + String(player1.experience_needed) ;
		
		get_node("HBox/Creature1UI/VBox/HBox2/EnergyLabel").text = "Energy:" + String(player1.stat[player1.STAT.ENERGY]) + " / " + String(player1.stat[player1.STAT.MAX_ENERGY]) ;
		if get_node("HBox/Creature1UI/VBox/HBox2").get_child_count() < 2:
			get_node("HBox/Creature1UI/VBox/HBox2").add_child(load("res://Source/CreatureTemplates/Resource System/ResourceGUI/EnergyBar.tscn").instance()) ;
		get_node("HBox/Creature1UI/VBox/HBox2").get_child(1).max_value = player1.stat[player1.STAT.MAX_ENERGY] ;
		get_node("HBox/Creature1UI/VBox/HBox2").get_child(1).value = player1.stat[player1.STAT.ENERGY] ;
	else:
		get_node("HBox/Creature1UI").visible = false ;
	
	if player2 != null:
		get_node("HBox/Creature2UI").visible = true ;
		get_node("HBox/Creature2UI/VBox/NameLabel").text = player2.creatureName ;
		get_node("HBox/Creature2UI/VBox/LevelLabel").text = "Level:" + String(player2.level) ;
		get_node("HBox/Creature2UI/VBox/HPLabel").text = "HP:" + String(player2.stat[1]) + " / " + String(player2.stat[0]) ;
		get_node("HBox/Creature2UI/VBox/EXPLabel").text = "EXP:" + String(player2.experience) + " / " + String(player2.experience_needed) ;
		
		get_node("HBox/Creature2UI/VBox/HBox2/EnergyLabel").text = "Energy:" + String(player2.stat[player2.STAT.ENERGY]) + " / " + String(player2.stat[player2.STAT.MAX_ENERGY]) ;
		#get_node("HBox/Creature1UI/VBox/HBox2/EnergyProgress").max_value = player2.stat[player2.STAT.MAX_ENERGY] ;
		#get_node("HBox/Creature1UI/VBox/HBox2/EnergyProgress").value = player2.stat[player2.STAT.ENERGY] ;
	else:
		get_node("HBox/Creature2UI").visible = false ;
