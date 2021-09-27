extends Control


func _ready():
	get_node("../../StateMachine/State").connect("ShowBattleStart", self, "ShowBattleStart") ;
	get_node("../../StateMachine/State").connect("ShowPlayerUI", self, "ShowPlayerUI") ;
	get_node("../../StateMachine/State").connect("ShowEnemyUI", self, "ShowEnemyUI") ;
	get_node("../../StateMachine/State").connect("DisplayBattleMenu", self, "DisplayBattleMenu") ;
	get_node("../../StateMachine/State").connect("DisplayItems", self, "DisplayItems") ;
	get_node("../../StateMachine/State").connect("DisplayMoves", self, "DisplayMoves") ;
	get_node("../../StateMachine/State").connect("DisplayTargetUI", self, "DisplayTargetUI") ;

func ShowBattleStart(player, enemy):
	$BattleLog.resetBattleLog() ;
	
	var t = Timer.new() ;
	add_child(t) ;
	t.one_shot = true ;
	t.autostart = false ;
	
	$BattleBeginPopup.visible = true ;
	t.wait_time = 1 ;
	t.start() ;
	yield(t, "timeout") ;
	
	$BattleBeginPopup/BattleBegingsLabel.set_text(player.name + " VS " + enemy.name) ;
	t.wait_time = 1 ;
	t.start() ;
	yield(t, "timeout") ;
	t.queue_free() ;
	
	$BattleBeginPopup.visible = false ;
	
	$BattleUIHandler.FinishBattleStart() ;


func ShowPlayerUI(player1, player2):
	$PlayerUI.displayPlayerUI(player1, player2) ;

func ShowEnemyUI(enemy1, enemy2):
	$EnemyUI.displayEnemyUI(enemy1, enemy2) ;

func DisplayBattleMenu(moves, items, switch, run):
	$BattleMenu.displayBattleMenu(moves, items, switch, run) ;

func DisplayItems(inv_dict):
	$ItemMenu.DisplayItems(inv_dict);

func DisplayMoves(moveList):
	$MoveMenu.DisplayMoves(moveList) ;

func DisplayTargetUI():
	$EnemyUI.DisplayTargetUI() ;




func _on_State_hideDisplayMoves():
	$MoveMenu.resetButtons() ;


func _on_BattleStart_showMoveMenu():
	$BattleMenu.showMoveMenu() ;


func _on_BaseCreature_updatePlayerUI(player):
	$PlayerUI.updatePlayerUI(player) ;

func _on_BaseCreature_updateEnemyUI(enemy):
	$EnemyUI.updateEnemyUI(enemy) ;

func _on_BaseCreature_updateBattleLog(text):
	$BattleLog.updateBattleLog(text) ;
