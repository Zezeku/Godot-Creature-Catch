extends Node2D


signal updatePlayerUI(player) ;
signal updateEnemyUI(enemy);
signal updateBattleLog(text) ;

func execute(source, moveUse, target):
	
	if source.moveList[moveUse].pre_execute(source):
		source.updateResource(source.moveList[moveUse].resourceCost, source.moveList[moveUse].resourceType.resourceName ) ;
		emit_signal("updateBattleLog", source.creatureName + " used " + source.moveList[moveUse].skillName + " on " + target.creatureName) ;
		source.moveList[moveUse].execute(source, target) ;
		
	
	if target.get_parent().get_parent().name != "Enemy":
		emit_signal("updatePlayerUI", target) ;
	if source.get_parent().get_parent().name != "Enemy":
		emit_signal("updatePlayerUI", source) ;
	if target.get_parent().get_parent().name == "Enemy":
		emit_signal("updateEnemyUI", target)
	if source.get_parent().get_parent().name == "Enemy":
		emit_signal("updateEnemyUI", source)
	else:
		pass
	
	if(target.stat[target.STAT.HP] <= 0):
		fainted(source, target) ;

func fainted(source, target):
	emit_signal("updateBattleLog", target.creatureName + " fainted") ;
	gainExp(source, target) ;
	var target_parent = target.get_parent().get_parent() ;
	var targetIndex = target_parent.battleTeam.find(target) ;
	target.visible = false ;
	target_parent.battleTeam[targetIndex] = null ;
	
	if target_parent.name == "Enemy":
		target_parent.get_node("Party").remove_child(target) ;
		target.queue_free() ;
	else:
		target_parent.get_node("Party").remove_child(target) ;
		target_parent.get_node("Fainted").add_child(target) ;

func gainExp(source, target) :
	source.experience += target.experience_given ;
	emit_signal("updateBattleLog", source.creatureName + " gained " + String(target.experience_given) + " exp") ;
	if(source.experience >= source.experience_needed):
		source.levelUp() ;
