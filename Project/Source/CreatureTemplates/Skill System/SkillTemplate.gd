extends Resource


class_name SkillTemplate

export(String) var skillName
export(String) var tool_tip


export(Resource) var resourceType
export(int) var resourceCost 

enum MOVE_TYPE {PHYSICAL, SPECIAL, STATUS}
export(MOVE_TYPE) var  move

#export(Resource) var moveTyping

export(int) var potency

enum STAT_TO_CHANGE {
	MAX_HP,
	HP,
	MAX_ENERGY,
	ENERGY, 
	MAX_RESOURCE, 
	RESOURCE,
	ATK, 
	SPATK, 
	DEF, 
	SPDEF, 
	SPD
	} ;
export(Array, STAT_TO_CHANGE) var statToChange
export(Array, float) var multiplier

export(Array, Resource) var skillEffect

#checking if enough energy
func pre_execute(source):
	return resourceCost <= source.getResource(resourceType.resourceName) ;

#skilleffects
#target cna be multiple
func execute(source, target):
	for skill in skillEffect.size():
		skillEffect[skill].execute(source, target, self)
	


