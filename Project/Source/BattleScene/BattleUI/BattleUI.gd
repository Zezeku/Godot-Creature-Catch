extends Control


func _ready():
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("ShowBattleStart", self, "ShowBattleStart") ;
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("ShowPlayerUI", self, "ShowPlayerUI") ;
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("ShowEnemyUI", self, "ShowEnemyUI") ;
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("DisplayBattleMenu", self, "DisplayBattleMenu") ;
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("DisplayItems", self, "DisplayItems") ;
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("DisplayMoves", self, "DisplayMoves") ;
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("DisplaySwitch", self, "DisplaySwitch") ;
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("DisplayTargetingUI", self, "DisplayTargetingUI") ;
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("ActivateTargetingUI", self, "ActivateTargetingUI") ;
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("ActivatePlayerTargetingUI", self, "ActivatePlayerTargetingUI") ;
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("HideItems", self, "HideItems") ;
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("HideMoves", self, "HideMoves") ;
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("HideSwitch", self, "HideSwitch") ;
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("HideTargetUI", self, "HideTargetUI") ;
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("UpdatePlayerUI_Switch", self, "UpdatePlayerUI_Switch") ;
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("UpdateTargetUI_Switch", self, "UpdateTargetUI_Switch") ;

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

func DisplaySwitch(Player):
	$SwitchMenu.DisplaySwitch(Player) ;

func DisplayTargetingUI(player1, player2, enemy1, enemy2):
	$TargetingUI.DisplayTargetingUI(player1, player2, enemy1, enemy2) ;

func ActivateTargetingUI(targets, target_select):
	$TargetingUI.ActivateTargetingUI(targets, target_select) ;

func ActivatePlayerTargetingUI(creature):
	$TargetingUI.ActivatePlayerTargetingUI(creature) ;
func HideMoves():
	$MoveMenu.resetButtons() ;

func HideItems():
	$ItemMenu.resetButtons() ;

func HideSwitch():
	$SwitchMenu.resetButtons() ;

func HideTargetUI():
	$TargetingUI.HideTargetingUI() ;

func _on_BaseCreature_updatePlayerUI(player):
	$PlayerUI.updatePlayerUI(player) ;

func _on_BaseCreature_updateEnemyUI(enemy):
	$EnemyUI.updateEnemyUI(enemy) ;

func _on_BaseCreature_updateBattleLog(text):
	$BattleLog.updateBattleLog(text) ;

func UpdatePlayerUI_Switch(creature, index):
	$PlayerUI.UpdatePlayerUI_Switch(creature, index) ;

func UpdateTargetUI_Switch(creature, index):
	$TargetingUI.UpdateTargetingUI_Switch(creature, index) ;
