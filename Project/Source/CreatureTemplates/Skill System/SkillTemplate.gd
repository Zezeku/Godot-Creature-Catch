extends Resource


class_name SkillTemplate

export(String) var skillName
export(String) var tool_tip


export(Resource) var resourceType
export(int) var resourceCost 

enum MOVE_TYPE {PHYSICAL, SPECIAL, STATUS}
export(MOVE_TYPE) var  move

export(Resource) var elementType

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
export(int) var timer

export(Array, Resource) var skillEffect

enum SKILL_TARGET{
	SELF,
	ALLY,
	ENEMY
	} ;
export(SKILL_TARGET) var skillTarget

## SKILL EFFECT INTERFACE ##
## 
## PRE EXECUTE - FUNCTION TO RUN BEFORE EXECUTE. ALL EFFECTS PRE EXECUTE MUST PASS TO RETURN TRUE
## EXECUTE - FUNCTION TO BE RUN ON USE/IMMEDIATE
## APPLY - FUNCTION TO BE RUN BEFORE ANOTHER EFFECTS EXECUTE
## REACT - FUNCTION TO BE RUN AFTER ANOTHER EFFECTS EXECUTE - TYPICALLY MEANS IT NEEDS A RESULT LIKE DAMAGE CALC
## UPDATE - FUNCTION TO BE RUN DURING A SPECIFIC BATTLE POINT
## DESTROY - FUNCTION TO BE RUN BY ONE OF THE ABOVE AS CONDITION ARE MET, FINAL FUNCTION + REMOVE ITSELF FROM EFFECTS LIST



#checking if enough energy
func pre_execute(source):
	return resourceCost <= source.getResource(resourceType.resourceName) ;
	#if aether, one more step - show all current aethers location
	#and retarget them, lose current effect on target

#Aether can be redistributed if not enough
#target can be multiple

func execute(source, target):
	
	BattleLog.updateBattleLog(source.creatureName + " used " + skillName + " on " + target.creatureName) ;
	
	source.updateResource(resourceCost, resourceType.resourceName)
	#aether needs to store cost and target somwehere
	
	for skill in skillEffect:
		skill.execute(source, target, self) ;
	


