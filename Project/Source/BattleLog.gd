extends PanelContainer

var battleCreatures = [] ;

func updateBattleLog(text):
	$VBox/BattleLog.text += "\n\n" + text ;
	

func resetBattleLog():
	$VBox/BattleLog.text = "" ;
