extends Resource

class_name CreatureTemplate

# basic data
export(String) var creatureName

export(float) var maxHP
export(int) var maxEnergy
export(int) var maxResource

export(float) var ATK
export(float) var SPATK
export(float) var DEF
export(float) var SPDEF
export(float) var SPD

export(Resource) var spriteSheet #resource for sprite sheet

export(Resource) var resourceType #resource for resource GUI, update

export(Array, Resource) var elementType #resource for type GUI, and check multipliers

export(Array, Resource) var skillList #will be resource later

export(Array, int) var moveLearn

func initialize(creature, level):
	#these should be equations based on level
	creature.stat[creature.STAT.MAX_HP] = int(maxHP * 2 * level + 8) ;
	creature.stat[creature.STAT.HP] =  int(maxHP * 2 * level + 8) ;
	creature.stat[creature.STAT.MAX_ENERGY] =  maxEnergy ;
	creature.stat[creature.STAT.ENERGY] =  maxEnergy ;
	creature.stat[creature.STAT.MAX_RESOURCE] = maxResource ;
	creature.stat[creature.STAT.RESOURCE] = maxResource ;
	creature.stat[creature.STAT.ATK] = int(ATK * level + 2);
	creature.stat[creature.STAT.SPATK] = int(SPATK * level + 2);
	creature.stat[creature.STAT.DEF] = int(DEF * level + 2);
	creature.stat[creature.STAT.SPDEF] = int(SPDEF * level + 2);
	creature.stat[creature.STAT.SPD] = int(SPD * level + 2);
	
	creature.creatureName = creatureName ;
	
	
	for skill in skillList.size():
		if moveLearn[skill] <= level:
			creature.moveList.append(skillList[skill]) ;
	
	for type in elementType.size():
		creature.creatureType.append(elementType[type]);
		
	creature.spriteSheet = spriteSheet ;
	creature.add_child(Sprite.new())
	creature.get_child(0).texture = spriteSheet ;
	creature.get_child(0).hframes = 4 ;
	creature.get_child(0).frame = 2 ;
	creature.get_child(0).scale = Vector2(2,2) ;
	
	resourceType.initialize(creature) ;

func levelUp(creature, level):
	creature.stat[creature.STAT.MAX_HP] = int(maxHP * 2 * level + 8) ;
	creature.stat[creature.STAT.ATK] = int(ATK * level + 2);
	creature.stat[creature.STAT.SPATK] = int(SPATK * level + 2);
	creature.stat[creature.STAT.DEF] = int(DEF * level + 2);
	creature.stat[creature.STAT.SPDEF] = int(SPDEF * level + 2);
	creature.stat[creature.STAT.SPD] = int(SPD * level + 2);
	
	#find offset in skill lsit so we dont add a skill twice
	var offset = creature.moveList.size() ; #ie 4 moves learned already
	for skill in (skillList.size() - offset): #we want to reduce to remaing 6 by sibtracting, 10 - 4 = 6
		if moveLearn[skill+offset] <= level: #add offset since for loop assumes 0 start, 0 + 4 = 4
			creature.moveList.append(skillList[skill+offset]) ;
			BattleLog.updateBattleLog(creature.creatureName + " has learned " + skillList[skill+offset].skillName) ;
