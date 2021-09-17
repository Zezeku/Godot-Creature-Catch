extends Resource

class_name DamageEffect


func execute(source, target, skill):
	
	var pre_damage;
	var type_mult ;
	var damage ;
	
	if skill.move == 0: #PHTSICAL ENUM
		pre_damage = source.stat[source.STAT.ATK] * (1 + skill.potency / 50) * source.stat_mult[source.STAT.ATK] - target.stat[target.STAT.DEF] * target.stat_mult[source.STAT.DEF]
	else: #Special ENUM
		pre_damage = source.stat[source.STAT.SPATK] * (1 + skill.potency / 50) * source.stat_mult[source.STAT.SPATK] - target.stat[target.STAT.SPDEF] * target.stat_mult[source.STAT.SPDEF]
		
	
	type_mult = TypeChart.getMatchUp(skill.elementType, target.creatureType)

	if type_mult == 0:
		BattleLog.updateBattleLog(target.creatureName + " is immune to " + skill.skillName) ;
	elif type_mult <= 0.4 :
		BattleLog.updateBattleLog(target.creatureName + " highly resisted " + skill.skillName) ;
	elif type_mult <= 0.7:
		BattleLog.updateBattleLog(target.creatureName + " resisted " + skill.skillName) ;
	elif type_mult <= 1:
		pass ;
	elif type_mult <= 1.4:
		BattleLog.updateBattleLog(skill.skillName + " is effective to " + target.creatureName) ;
	elif type_mult <= 1.7:
		BattleLog.updateBattleLog(skill.skillName + " is extra effective to " + target.creatureName) ;
	else:
		pass;
	
	damage = clamp(int(pre_damage*type_mult),1,target.stat[target.STAT.HP])
	target.updateHP(damage) ; #do damage to target, check for fainted here!
	
