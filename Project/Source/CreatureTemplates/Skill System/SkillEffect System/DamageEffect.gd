extends Resource

class_name DamageEffect


func execute(source, target, skill):
	
	print("damage from damageeffect resource") ;
	var damage = clamp(source.stat[source.STAT.ATK] * (1 + skill.potency / 150) * source.stat_mult[source.STAT.ATK] - target.stat[target.STAT.DEF] * target.stat_mult[source.STAT.DEF],1,target.stat[target.STAT.HP]) ;
	target.stat[source.STAT.HP] -= clamp(int(damage), 1, target.stat[target.STAT.HP]) ;
	
	print(source.name, " did ", damage, " to ", target.name, " !") ;
		#need to check for fainted
	
