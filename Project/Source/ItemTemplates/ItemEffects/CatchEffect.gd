extends Resource

class_name itemEffect

func execute(source, target, item):
	var rng = RandomNumberGenerator.new() ;
	rng.randomize() ;
	
	if rng.randf_range(0,1) <= item.catchRate:
		#find the target in the parent battleteam, and set it to null
		target.get_parent().get_parent().battleTeam[target.get_parent().get_parent().battleTeam.find(target)] = null ;
		
		target.get_parent().remove_child(target) ;
		target.UpdateEnemyUI_Caught() ;
		target.UpdateTargetingUI_Caught() ;
		source.add_child(target) ;
		#source.get_parent().updatePlayerMenu(target) ;
		BattleLog.updateBattleLog("\nYou caught " + target.creatureName + " !!!") ;
	
	else:
		BattleLog.updateBattleLog(target.name + " escaped the net!") ;



