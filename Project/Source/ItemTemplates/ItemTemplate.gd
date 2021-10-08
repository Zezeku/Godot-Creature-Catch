extends Resource


class_name ItemResource 

export(String) var itemName

enum ITEM_TYPE {STANDARD, HEAL, HELD, BATTLE, KEY}
export(ITEM_TYPE) var itemType

export(int)var maxStack

export(Array, Resource) var itemEffects

export(float) var catchRate

enum SKILL_TARGET{
	SELF,
	ALLY,
	ENEMY
	} ;
export(SKILL_TARGET) var skillTarget

func initialize(itemX):
	
	itemX.itemName = itemName ;
	
	for i in itemEffects.size():
		itemX.itemEffects.append(itemEffects[i]) ;
	
	
func execute(source, target, state):
	for i in itemEffects.size():
		yield(itemEffects[i].execute(source, target, self, state), "completed") ;

