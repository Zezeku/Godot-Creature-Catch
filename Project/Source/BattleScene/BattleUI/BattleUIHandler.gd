extends Node


signal FinishBattleStart ;
signal BattleMenuSelect(menuSelection) ;
signal ItemSelect(item_key);
signal MoveSelect(moveSelection) ;
signal TargetSelect(targetSelect) ;

func FinishBattleStart():
	emit_signal("FinishBattleStart") ;

func BattleMenuSelect(menuSelection):
	emit_signal("BattleMenuSelect", menuSelection) ;

func ItemSelect(item_key):
	emit_signal("ItemSelect", item_key) ;

func MoveSelect(moveSelection):
	emit_signal("MoveSelect", moveSelection) ;

func TargetSelect(targetSelect):
	emit_signal("TargetSelect", targetSelect) ;
