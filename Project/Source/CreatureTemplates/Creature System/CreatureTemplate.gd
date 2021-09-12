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

export(Resource) var creatureType #resource for type GUI, and check multipliers

export(Array, String) var moveList #will be resource later
export(Array, Resource) var moveLearn

func initialize(creature, level):
	#these should be equations based on level
	creature.stat[creature.STAT.MAX_HP] = int(maxHP * 2 * level + 8) ;
	creature.stat[creature.STAT.HP] =  int(maxHP * 2 * level + 8) ;
	creature.stat[creature.STAT.MAX_ENERGY] =  maxEnergy ;
	creature.stat[creature.STAT.MAX_RESOURCE] = maxResource ;
	creature.stat[creature.STAT.ATK] = int(ATK * level + 2);
	creature.stat[creature.STAT.SPATK] = int(SPATK * level + 2);
	creature.stat[creature.STAT.DEF] = int(DEF * level + 2);
	creature.stat[creature.STAT.SPDEF] = int(SPDEF * level + 2);
	creature.stat[creature.STAT.SPD] = int(SPD * level + 2);
	
	creature.creatureName = creatureName ;
	
	creature.spriteSheet = spriteSheet ;
	creature.add_child(Sprite.new())
	creature.get_child(0).texture = spriteSheet ;
	creature.get_child(0).hframes = 4 ;
	creature.get_child(0).frame = 2 ;
	creature.get_child(0).scale = Vector2(2,2) ;
	
	creature.moveList = moveList ; #eventually a Resource
	
	resourceType.initialize(creature) ;

func levelUp(creature, level):
	print("LEVEL UP to ", level) ;
	creature.stat[creature.STAT.MAX_HP] = int(maxHP * 2 * level + 8) ;
	creature.stat[creature.STAT.ATK] = int(ATK * level + 2);
	creature.stat[creature.STAT.SPATK] = int(SPATK * level + 2);
	creature.stat[creature.STAT.DEF] = int(DEF * level + 2);
	creature.stat[creature.STAT.SPDEF] = int(SPDEF * level + 2);
	creature.stat[creature.STAT.SPD] = int(SPD * level + 2);
	
