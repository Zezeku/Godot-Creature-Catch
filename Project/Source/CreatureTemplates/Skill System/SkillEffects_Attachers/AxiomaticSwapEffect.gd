extends Resource


class_name AxiomaticSwapEffect

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
	
	var source_atk = source.stat[source.STAT.ATK] ;
	var source_spatk = source.stat[source.STAT.SPATK] ;
	var source_atk_mult = source.stat_mult[source.STAT.ATK] ;
	var source_spatk_mult = source.stat_mult[source.STAT.SPATK] ;
	
	source.stat[source.STAT.ATK] = source_spatk ;
	source.stat[source.STAT.SPATK] = source_atk ;
	source.stat_mult[source.STAT.ATK] = source_spatk_mult ;
	source.stat_mult[source.STAT.SPATK] = source_atk_mult ;
	
	#look at exporting this to remove path dependency ;
	#we export this effect in case any changes need to be made
	var debuffEffect = load("res://Source/CreatureTemplates/Skill System/SkillEffects_Attachers/DebuffEffect.gd").new() ;
	debuffEffect.execute(self) ;

func destroy():
	var source_atk = my_source.stat[my_source.STAT.ATK] ;
	var source_spatk = my_source.stat[my_source.STAT.SPATK] ;
	var source_atk_mult = my_source.stat_mult[my_source.STAT.ATK] ;
	var source_spatk_mult = my_source.stat_mult[my_source.STAT.SPATK] ;
	
	my_source.stat[my_source.STAT.ATK] = source_spatk ;
	my_source.stat[my_source.STAT.SPATK] = source_atk ;
	my_source.stat_mult[my_source.STAT.ATK] = source_spatk_mult ;
	my_source.stat_mult[my_source.STAT.SPATK] = source_atk_mult ;
	
	#not sure this is necessary once targeting is correct
	if !my_source.is_queued_for_deletion():
		my_source.updateResource(-1*my_resourceCost, "Aether") ;
	
