extends Resource


class_name StatEffect

func execute(source, target, skill):
	
	for stat in skill.statToChange.size():
		target.stat_mult[skill.statToChange[stat]] += skill.multiplier[stat] ;
