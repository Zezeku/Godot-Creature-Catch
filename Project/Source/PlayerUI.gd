extends Control

var creature1 ;
var creature2 ;

func displayPlayerUI(player1, player2):
	
	creature1 = player1 ;
	creature2 = player2 ;
	
	if creature1 != null:
		get_node("HBox/Creature1UI").visible = true ;
		get_node("HBox/Creature1UI/VBox/NameLabel").text = player1.creatureName ;
		get_node("HBox/Creature1UI/VBox/LevelLabel").text = "Level:" + String(player1.level) ;
		get_node("HBox/Creature1UI/VBox/HPLabel").text = "HP:" + String(player1.stat[1]) + " / " + String(player1.stat[0]) ;
		get_node("HBox/Creature1UI/VBox/EXPLabel").text = "EXP:" + String(player1.experience) + " / " + String(player1.experience_needed) ;
		
		get_node("HBox/Creature1UI/VBox/HBox2/EnergyLabel").text = "Energy:" + String(player1.stat[player1.STAT.ENERGY]) + " / " + String(player1.stat[player1.STAT.MAX_ENERGY]) ;
		get_node("HBox/Creature1UI/VBox/HBox2").add_child(load("res://Source/CreatureTemplates/Resource System/ResourceGUI/EnergyBar.tscn").instance()) ;
		get_node("HBox/Creature1UI/VBox/HBox2").get_child(1).max_value = player1.stat[player1.STAT.MAX_ENERGY] ;
		get_node("HBox/Creature1UI/VBox/HBox2").get_child(1).value = player1.stat[player1.STAT.ENERGY] ;
		
		get_node("HBox/Creature1UI/VBox/HBox3/ResourceLabel").text = String(player1.resourceType.resourceName) + ": " + String(player1.stat[player1.STAT.RESOURCE]) + " / " + String(player1.stat[player1.STAT.MAX_RESOURCE]) ;
		get_node("HBox/Creature1UI/VBox/HBox3").add_child(creature1.resourceType.resourceGUI.instance()) ;
		get_node("HBox/Creature1UI/VBox/HBox3").get_child(1).max_value = player1.stat[player1.STAT.MAX_RESOURCE] ;
		get_node("HBox/Creature1UI/VBox/HBox3").get_child(1).value = player1.stat[player1.STAT.RESOURCE] ;
		
	else:
		get_node("HBox/Creature1UI").visible = false ;
	
	if creature2 != null:
		get_node("HBox/Creature2UI").visible = true ;
		get_node("HBox/Creature2UI/VBox/NameLabel").text = player2.creatureName ;
		get_node("HBox/Creature2UI/VBox/LevelLabel").text = "Level:" + String(player2.level) ;
		get_node("HBox/Creature2UI/VBox/HPLabel").text = "HP:" + String(player2.stat[1]) + " / " + String(player2.stat[0]) ;
		get_node("HBox/Creature2UI/VBox/EXPLabel").text = "EXP:" + String(player2.experience) + " / " + String(player2.experience_needed) ;
		
		get_node("HBox/Creature2UI/VBox/HBox2/EnergyLabel").text = "Energy:" + String(player2.stat[player2.STAT.ENERGY]) + " / " + String(player2.stat[player2.STAT.MAX_ENERGY]) ;
		get_node("HBox/Creature2UI/VBox/HBox2").add_child(load("res://Source/CreatureTemplates/Resource System/ResourceGUI/EnergyBar.tscn").instance()) ;
		get_node("HBox/Creature2UI/VBox/HBox2").get_child(1).max_value = player2.stat[player2.STAT.MAX_ENERGY] ;
		get_node("HBox/Creature2UI/VBox/HBox2").get_child(1).value = player2.stat[player2.STAT.ENERGY] ;
		
		get_node("HBox/Creature2UI/VBox/HBox3/ResourceLabel").text = String(player2.resourceType.resourceName) + ": " + String(player2.stat[player2.STAT.RESOURCE]) + " / " + String(player2.stat[player2.STAT.MAX_RESOURCE]) ;
		get_node("HBox/Creature2UI/VBox/HBox3").add_child(creature2.resourceType.resourceGUI.instance()) ;
		get_node("HBox/Creature2UI/VBox/HBox3").get_child(1).max_value = player2.stat[player2.STAT.MAX_RESOURCE] ;
		get_node("HBox/Creature2UI/VBox/HBox3").get_child(1).value = player2.stat[player2.STAT.RESOURCE] ;
	else:
		get_node("HBox/Creature2UI").visible = false ;

func updatePlayerUI(player):
	if player == creature1:
		get_node("HBox/Creature1UI/VBox/HPLabel").text = "HP:" + String(player.stat[1]) + " / " + String(player.stat[0]) ;
		get_node("HBox/Creature1UI/VBox/HBox2/EnergyLabel").text = "Energy:" + String(player.stat[player.STAT.ENERGY]) + " / " + String(player.stat[player.STAT.MAX_ENERGY]) ;
		get_node("HBox/Creature1UI/VBox/HBox2").get_child(1).max_value = player.stat[player.STAT.MAX_ENERGY] ;
		get_node("HBox/Creature1UI/VBox/HBox2").get_child(1).value = player.stat[player.STAT.ENERGY] ;
		
		get_node("HBox/Creature1UI/VBox/HBox3/ResourceLabel").text = String(player.resourceType.resourceName) + ": " + String(player.stat[player.STAT.RESOURCE]) + " / " + String(player.stat[player.STAT.MAX_RESOURCE]) ;
		get_node("HBox/Creature1UI/VBox/HBox3").get_child(1).max_value = player.stat[player.STAT.MAX_RESOURCE] ;
		get_node("HBox/Creature1UI/VBox/HBox3").get_child(1).value = player.stat[player.STAT.RESOURCE] ;
	else:
		get_node("HBox/Creature2UI/VBox/HPLabel").text = "HP:" + String(player.stat[1]) + " / " + String(player.stat[0]) ;
		get_node("HBox/Creature2UI/VBox/HBox2/EnergyLabel").text = "Energy:" + String(player.stat[player.STAT.ENERGY]) + " / " + String(player.stat[player.STAT.MAX_ENERGY]) ;
		get_node("HBox/Creature2UI/VBox/HBox2").get_child(1).max_value = player.stat[player.STAT.MAX_ENERGY] ;
		get_node("HBox/Creature2UI/VBox/HBox2").get_child(1).value = player.stat[player.STAT.ENERGY] ;
		
		get_node("HBox/Creature2UI/VBox/HBox3/ResourceLabel").text = String(player.resourceType.resourceName) + ": " + String(player.stat[player.STAT.RESOURCE]) + " / " + String(player.stat[player.STAT.MAX_RESOURCE]) ;
		get_node("HBox/Creature2UI/VBox/HBox3").get_child(1).max_value = player.stat[player.STAT.MAX_RESOURCE] ;
		get_node("HBox/Creature2UI/VBox/HBox3").get_child(1).value = player.stat[player.STAT.RESOURCE] ;


