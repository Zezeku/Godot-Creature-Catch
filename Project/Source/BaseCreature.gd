extends Node2D


signal updatePlayerUI(player1, player2) ;
signal updateEnemyUI(enemy1, enemy2);

func execute(source, moveUse, target):
	
	if source.moveList[moveUse].pre_execute(source):
		source.updateResource(source.moveList[moveUse].resourceCost, source.moveList[moveUse].resourceType.resourceName ) ;
		source.moveList[moveUse].execute(source, target) ;
	
	if target.get_parent().get_parent().name != "Enemy" and target == target.get_parent().get_parent().battleTeam[0]:
		emit_signal("updatePlayerUI", target, null)
	elif target.get_parent().get_parent().name != "Enemy" and target == target.get_parent().get_parent().battleTeam[1]:
		emit_signal("updatePlayerUI", null, target)
	elif target.get_parent().get_parent().name == "Enemy" and target == target.get_parent().get_parent().battleTeam[0]:
		emit_signal("updateEnemyUI", target, null)
	elif target.get_parent().get_parent().name == "Enemy" and target == target.get_parent().get_parent().battleTeam[1]:
		emit_signal("updateEnemyUI", null, target)
	else:
		pass
	
	if(target.stat[target.STAT.HP] <= 0):
		fainted(source, target) ;

func fainted(source, target):
	gainExp(source, target) ;
	var target_parent = target.get_parent() ;
	var targetIndex = target_parent.get_parent().battleTeam.find(target) ;
	target.visible = false ;
	target_parent.get_parent().battleTeam[targetIndex] = null ;
	if target_parent.name == "Enemy":
		target_parent.remove_child(target) ;
		target.queue_free() ;
	#how to handle fainted creature?

func gainExp(source, target) :
	print(source.name, " gained ", target.experience_given, " exp!") ;
	source.experience += target.experience_given ;
	if(source.experience >= source.experience_needed):
		print(source.name, " grew to level ", (source.level+1), " !") ;
		source.levelUp() ;
