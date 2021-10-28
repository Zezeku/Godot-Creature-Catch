extends Node

#this could be done the same as all the other UI
#connect state in battle UI, and creatures in BattleLog itself
func updateBattleLog(text):
	get_node("../SceneHandler/BattleScene/CanvasLayer/BattleUI/BattleLog").updateBattleLog(text) ;

