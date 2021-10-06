extends Resource

class_name MarkEffect 

var my_source ;
var my_target ;
var my_skill ;
var my_resourceType ;
var my_resourceCost ;

func execute(source, target, skill):
	my_source = source ;
	my_target = target ;
	my_skill = skill ;
	my_resourceType = skill.resourceType ;
	my_resourceCost = skill.resourceCost ;
	
	#look at exporting this to remove path dependency ;
	#we export this effect in case any changes need to be made
	var debuffEffect = load("res://Source/CreatureTemplates/Skill System/SkillEffects_Attachers/DebuffEffect.gd").new() ;
	debuffEffect.execute(self) ;

func apply(source, _target, skill):
	
	if skill.effect_name == "DamageEffect":
		if source == my_source:
			if skill.type_mult > 0 and skill.type_mult <= 0.4:
				skill.type_mult = float(2/3) ;
			elif skill.type_mult > 0.4 and skill.type_mult < 1:
				skill.type_mult = float(1) ;
			else:
				pass
		else:
			pass ;
