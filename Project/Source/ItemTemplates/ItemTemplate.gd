extends Resource


class_name ItemResource 

export(String) var itemName

enum ITEM_TYPE {STANDARD, HEAL, HELD, BATTLE, KEY}
export(ITEM_TYPE) var itemType

export(int)var maxStack

export(Array, Resource) var itemEffects

export(float) var catchRate

func initialize(itemX):
	
	itemX.itemName = itemName ;
	
	for i in itemEffects.size():
		itemX.itemEffects.append(itemEffects[i]) ;
	
	
func execute(source, target):
	for i in itemEffects.size():
		itemEffects[i].execute(source, target, self) ;

