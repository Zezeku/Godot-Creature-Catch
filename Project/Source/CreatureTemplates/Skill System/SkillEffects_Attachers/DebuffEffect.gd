extends Resource


class_name DebuffEffect

func execute(skill):
	#try to duplicate the skill here, and pass the new variable into append
	
	var skill_copy = skill.duplicate() ;
	skill_copy.my_source = skill.my_source ;
	skill_copy.my_target = skill.my_target ;
	skill_copy.my_skill = skill.my_skill ;
	skill_copy.my_resourceType = skill.my_resourceType ;
	skill_copy.my_resourceCost = skill.my_resourceCost ;
	
	skill.my_target.moveEffects.append(skill_copy) ;
	skill.my_source.targetEffects.append(skill_copy) ;
