extends Control


signal battle_start ;


func _on_BattleStart_ShowBattleStart(player, enemy):
	
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
	
	emit_signal("battle_start") ;


func _on_State_DisplayMoves(moveList):
	$MoveMenu.DisplayMoves(moveList) ;
	
func _on_State_hideDisplayMoves():
	$MoveMenu.resetButtons() ;

func _on_State_DisplayMenu(creature):
	$BattleMenu.displayBattleMenu() ;

func _on_BattleStart_showMoveMenu():
	$BattleMenu.showMoveMenu() ;

func _on_BattleStart_ShowItemMenu():
	$BattleMenu.showItemMenu() ;
	
func _on_State_hideDisplayItems():
	$ItemMenu.resetButtons() ;

func _on_State_DisplayItems(items, items_amount):
	$ItemMenu.displayItems(items, items_amount);

func _on_BattleStart_ShowBattleUI(player1, player2):
	$PlayerUI.displayPlayerUI(player1, player2) ;


func _on_BaseCreature_updatePlayerUI(player):
	$PlayerUI.updatePlayerUI(player) ;


func _on_BattleStart_ShowEnemyUI(enemy1, enemy2):
	$EnemyUI.displayEnemyUI(enemy1, enemy2) ;


func _on_BaseCreature_updateEnemyUI(enemy):
	$EnemyUI.updateEnemyUI(enemy) ;


func _on_BaseCreature_updateBattleLog(text):
	$BattleLog.updateBattleLog(text) ;
