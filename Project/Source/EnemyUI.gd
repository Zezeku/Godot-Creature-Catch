extends Control



func displayEnemyUI(enemy1, enemy2):
	
	if enemy1 != null:
		get_node("HBox/Creature1UI").visible = true ;
		get_node("HBox/Creature1UI/VBox/NameLabel").text = enemy1.creatureName ;
		get_node("HBox/Creature1UI/VBox/LevelLabel").text = "Level:" + String(enemy1.level) ;
		get_node("HBox/Creature1UI/VBox/HPLabel").text = "HP:" + String(enemy1.stat[1]) + " / " + String(enemy1.stat[0]) ;
	else:
		get_node("HBox/Creature1UI").visible = false ;
	
	if enemy2 != null:
		get_node("HBox/Creature2UI").visible = true ;
		get_node("HBox/Creature2UI/VBox2/NameLabel").text = enemy2.creatureName ;
		get_node("HBox/Creature2UI/VBox2/LevelLabel").text = "Level:" + String(enemy2.level) ;
		get_node("HBox/Creature2UI/VBox2/HPLabel").text = "HP:" + String(enemy2.stat[1]) + " / " + String(enemy2.stat[0]) ;
	else:
		get_node("HBox/Creature2UI").visible = false ;
