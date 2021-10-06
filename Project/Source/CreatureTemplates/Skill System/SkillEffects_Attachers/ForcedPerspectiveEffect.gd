extends Resource


class_name ForcedPerspectiveEffect

var my_source ;
var my_target ;
var my_skill ;
var my_resourceType ;
var my_resourceCost ;

func execute(source, target, skill):
	my_source = source ;
	my_target = target ; #this needs to be ally
	my_skill = skill ;
	my_resourceType = skill.resourceType ;
	my_resourceCost = skill.resourceCost ;
	
	#look at exporting this to remove path dependency ;
	#we export this effect in case any changes need to be made
	var debuffEffect = load("res://Source/CreatureTemplates/Skill System/SkillEffects_Attachers/DebuffEffect.gd").new() ;
	debuffEffect.execute(self) ;

func react(_source, _target, skill):
	if skill.effect_name == "DamageEffect":
		if my_target.resourceType.resourceName == "Rage":
			#adds 20% to the rage calculation
			var addRec = int( 0.2 * (my_target.stat[my_target.STAT.MAX_RESOURCE] * 2 * skill.damage / my_target.stat[my_target.STAT.MAX_HP] ) );
			var rageCap = my_target.stat[my_target.STAT.MAX_RESOURCE] - my_target.stat[my_target.STAT.RESOURCE] ;
			print("forced perspective react(): addRec: ", addRec) ;
			my_target.stat[my_target.STAT.RESOURCE] += clamp(addRec,1,rageCap) ;
	
