extends Node


signal FinishBattleStart ;
signal BattleMenuSelect(menuSelection) ;
signal ItemSelect(item_key);
signal MoveSelect(moveSelection) ;
signal SwitchSelect(creatureSelection) ;
signal TargetSelect(targetSelect) ;
signal AetherDistribute ;

func FinishBattleStart():
	emit_signal("FinishBattleStart") ;

func BattleMenuSelect(menuSelection):
	emit_signal("BattleMenuSelect", menuSelection) ;

func ItemSelect(item_key):
	emit_signal("ItemSelect", item_key) ;

func MoveSelect(moveSelection):
	emit_signal("MoveSelect", moveSelection) ;

func SwitchSelect(creatureSelection):
	emit_signal("SwitchSelect", creatureSelection) ;

func TargetSelect(targetSelect):
	emit_signal("TargetSelect", targetSelect) ;

func AetherDistribute():
	emit_signal("AetherDistribute") ;
