extends Control

var creature1 ;
var creature2 ;

func displayEnemyUI(enemy1, enemy2):
	
	creature1 = enemy1 ;
	creature2 = enemy2 ;
	
	if enemy1 != null:
		get_node("HBox/Creature1UI").visible = true ;
		get_node("HBox/Creature1UI/VBox/NameLabel").text = enemy1.creatureName ;
		get_node("HBox/Creature1UI/VBox/LevelLabel").text = "Level:" + String(enemy1.level) ;
		get_node("HBox/Creature1UI/VBox/HPLabel").text = "HP:" + String(enemy1.stat[1]) + " / " + String(enemy1.stat[0]) ;
		
		get_node("HBox/Creature1UI/VBox/HBox2/EnergyLabel").text = "Energy:" + String(creature1.stat[creature1.STAT.ENERGY]) + " / " + String(creature1.stat[creature1.STAT.MAX_ENERGY]) ;
		get_node("HBox/Creature1UI/VBox/HBox2").add_child(load("res://Source/CreatureTemplates/Resource System/ResourceGUI/EnergyBar.tscn").instance()) ;
		get_node("HBox/Creature1UI/VBox/HBox2").get_child(1).max_value = creature1.stat[creature1.STAT.MAX_ENERGY] ;
		get_node("HBox/Creature1UI/VBox/HBox2").get_child(1).value = creature1.stat[creature1.STAT.ENERGY] ;
		
		get_node("HBox/Creature1UI/VBox/HBox3/ResourceLabel").text = String(creature1.resourceType.resourceName) + ": " + String(creature1.stat[creature1.STAT.RESOURCE]) + " / " + String(creature1.stat[creature1.STAT.MAX_RESOURCE]) ;
		get_node("HBox/Creature1UI/VBox/HBox3").add_child(creature1.resourceType.resourceGUI.instance()) ;
		get_node("HBox/Creature1UI/VBox/HBox3").get_child(1).max_value = creature1.stat[creature1.STAT.MAX_RESOURCE] ;
		get_node("HBox/Creature1UI/VBox/HBox3").get_child(1).value = creature1.stat[creature1.STAT.RESOURCE] ;
	else:
		get_node("HBox/Creature1UI").visible = false ;
	
	if enemy2 != null:
		get_node("HBox/Creature2UI").visible = true ;
		get_node("HBox/Creature2UI/VBox2/NameLabel").text = enemy2.creatureName ;
		get_node("HBox/Creature2UI/VBox2/LevelLabel").text = "Level:" + String(enemy2.level) ;
		get_node("HBox/Creature2UI/VBox2/HPLabel").text = "HP:" + String(enemy2.stat[1]) + " / " + String(enemy2.stat[0]) ;
		
		get_node("HBox/Creature2UI/VBox2/HBox2/EnergyLabel").text = "Energy:" + String(creature2.stat[creature2.STAT.ENERGY]) + " / " + String(creature2.stat[creature2.STAT.MAX_ENERGY]) ;
		get_node("HBox/Creature2UI/VBox2/HBox2").add_child(load("res://Source/CreatureTemplates/Resource System/ResourceGUI/EnergyBar.tscn").instance()) ;
		get_node("HBox/Creature2UI/VBox2/HBox2").get_child(1).max_value = creature2.stat[creature2.STAT.MAX_ENERGY] ;
		get_node("HBox/Creature2UI/VBox2/HBox2").get_child(1).value = creature2.stat[creature2.STAT.ENERGY] ;
		
		get_node("HBox/Creature2UI/VBox2/HBox3/ResourceLabel").text = String(creature2.resourceType.resourceName) + ": " + String(creature2.stat[creature2.STAT.RESOURCE]) + " / " + String(creature2.stat[creature2.STAT.MAX_RESOURCE]) ;
		get_node("HBox/Creature2UI/VBox2/HBox3").add_child(creature2.resourceType.resourceGUI.instance()) ;
		get_node("HBox/Creature2UI/VBox2/HBox3").get_child(1).max_value = creature2.stat[creature2.STAT.MAX_RESOURCE] ;
		get_node("HBox/Creature2UI/VBox2/HBox3").get_child(1).value = creature2.stat[creature2.STAT.RESOURCE] ;
	else:
		get_node("HBox/Creature2UI").visible = false ;

func updateEnemyUI(enemy):
	
	if enemy == creature1 and creature1.stat[creature1.STAT.HP] > 0:
		get_node("HBox/Creature1UI/VBox/HPLabel").text = "HP:" + String(enemy.stat[1]) + " / " + String(enemy.stat[0]) ;
		
		get_node("HBox/Creature1UI/VBox/HBox2/EnergyLabel").text = "Energy:" + String(enemy.stat[enemy.STAT.ENERGY]) + " / " + String(enemy.stat[enemy.STAT.MAX_ENERGY]) ;
		get_node("HBox/Creature1UI/VBox/HBox2").get_child(1).max_value = enemy.stat[enemy.STAT.MAX_ENERGY] ;
		get_node("HBox/Creature1UI/VBox/HBox2").get_child(1).value = enemy.stat[enemy.STAT.ENERGY] ;
		
		get_node("HBox/Creature1UI/VBox/HBox3/ResourceLabel").text = String(creature1.resourceType.resourceName) + ": " + String(creature1.stat[creature1.STAT.RESOURCE]) + " / " + String(creature1.stat[creature1.STAT.MAX_RESOURCE]) ;
		get_node("HBox/Creature1UI/VBox/HBox3").get_child(1).max_value = creature1.stat[creature1.STAT.MAX_RESOURCE] ;
		get_node("HBox/Creature1UI/VBox/HBox3").get_child(1).value = creature1.stat[creature1.STAT.RESOURCE] ;
	elif enemy == creature1:
		 get_node("HBox/Creature1UI").visible = false ;
	
	elif enemy == creature2 and creature2.stat[creature1.STAT.HP] > 0:
		get_node("HBox/Creature2UI/VBox2/HPLabel").text = "HP:" + String(enemy.stat[1]) + " / " + String(enemy.stat[0]) ;
		
		get_node("HBox/Creature2UI/VBox2/HBox2/EnergyLabel").text = "Energy:" + String(enemy.stat[enemy.STAT.ENERGY]) + " / " + String(enemy.stat[enemy.STAT.MAX_ENERGY]) ;
		get_node("HBox/Creature2UI/VBox2/HBox2").get_child(1).max_value = enemy.stat[enemy.STAT.MAX_ENERGY] ;
		get_node("HBox/Creature2UI/VBox2/HBox2").get_child(1).value = enemy.stat[enemy.STAT.ENERGY] ;
		
		get_node("HBox/Creature2UI/VBox2/HBox3/ResourceLabel").text = String(creature2.resourceType.resourceName) + ": " + String(creature2.stat[creature2.STAT.RESOURCE]) + " / " + String(creature2.stat[creature2.STAT.MAX_RESOURCE]) ;
		get_node("HBox/Creature2UI/VBox2/HBox3").get_child(1).max_value = creature2.stat[creature2.STAT.MAX_RESOURCE] ;
		get_node("HBox/Creature2UI/VBox2/HBox3").get_child(1).value = creature2.stat[creature2.STAT.RESOURCE] ;
	else:
		get_node("HBox/Creature2UI").visible = false ;
