extends Resource

class_name itemEffect

func execute(source, target, item, state):
	var rng = RandomNumberGenerator.new() ;
	rng.randomize() ;
	
	state.add_child(load("res://Source/ItemTemplates/CatchMiniGame.tscn").instance()) ;
	#this is Godot semantics. yield must return a GDState so that external yieeld can intpret this yield as completed
	#we yield on a single idle frame to do this
	#we can cascade this as needed
	print("yield - item ", item.itemName, ", source: ", source.name, ", target: ", target.creatureName )
	var isSuccess = yield(state.get_child(0).execute(), "completed") ;
	print("unyield - item")
	
	var deleteNode = state.get_child(0)
	state.remove_child(deleteNode)
	deleteNode.queue_free() ;
	
	if isSuccess : #rng.randf_range(0,1) <= item.catchRate:
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



