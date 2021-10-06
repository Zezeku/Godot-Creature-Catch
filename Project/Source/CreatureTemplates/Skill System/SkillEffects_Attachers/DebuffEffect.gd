extends Resource


class_name DebuffEffect

func execute(skill):
	skill.my_target.moveEffects.append(skill) ;
	
