extends Resource


class_name StatEffect

func execute(source, target, skill):
	
	print("stat_mult deom stateffect") ;
	for stat in skill.statToChange.size():
		target.stat_mult[skill.statToChange[stat]] += skill.multiplier[stat] ;
