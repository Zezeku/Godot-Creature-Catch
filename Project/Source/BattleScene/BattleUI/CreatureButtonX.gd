extends Button


var creatureX ;

signal switch_pressed(creature_to_switch) ;

func initSwitchButton():
	$HBox/Sprite.texture = creatureX.spriteSheet ;
	$HBox/HP.text = "HP: " + String(creatureX.stat[creatureX.STAT.HP]) + " / " + String(creatureX.stat[creatureX.STAT.MAX_HP]) ;
	


func _on_Creature_pressed():
	emit_signal("switch_pressed", creatureX) ;
