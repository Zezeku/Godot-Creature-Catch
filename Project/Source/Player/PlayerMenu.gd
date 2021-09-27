extends Control


onready var creatureData = get_node("CanvasLayer/CreaturePanel/CreatureSlot/Split/CreatureData") ;
onready var creatureMove1 = get_node("CanvasLayer/CreaturePanel/CreatureSlot/Split/CreatureMove1") ;
onready var creatureMove2 = get_node("CanvasLayer/CreaturePanel/CreatureSlot/Split/CreatureMove2") ;
onready var creatureMove3 = get_node("CanvasLayer/CreaturePanel/CreatureSlot/Split/CreatureMove3") ;
onready var creatureMove4 = get_node("CanvasLayer/CreaturePanel/CreatureSlot/Split/CreatureMove4") ;


func _ready():
	resetPlayerMenu() ;

func updatePlayerMenu(creature):
	
	creatureData.get_node("CreatureSprite/Sprite").texture = creature.spriteSheet ;
	creatureData.get_node("CreatureSprite/Sprite").frame = 0 ;
	
	creatureData.get_node("CreatureType/Type1Name").text = creature.creatureType[0].elementName ;
	if creature.creatureType.size() > 1:
		creatureData.get_node("CreatureType/Type2Name").text = creature.creatureType[1].elementName ;
	else:
		creatureData.get_node("CreatureType/Type2Name").text = "";
	
	creatureData.get_node("CreatureInfo/CreatureName").text = creature.creatureName ;
	creatureData.get_node("CreatureInfo/CreatureLv").text = "Lv " + String(creature.level) ;
	creatureData.get_node("CreatureInfo/CreatureExp").text = "Exp " + String(creature.experience) + " / " + String(creature.experience_needed) ;
	
	creatureData.get_node("CreatureStats1/CreatureHP").text = "HP " + String(creature.stat[1]) + " / " + String(creature.stat[0]) ;
	creatureData.get_node("CreatureStats1/CreatureEnergy").text = "Energy " + String(creature.stat[3]) + " / " + String(creature.stat[2]) ;
	creatureData.get_node("CreatureStats1/CreatureResource").text = creature.resourceType.resourceName + String(creature.stat[5]) + " / " + String(creature.stat[4]) ;
	
	creatureData.get_node("CreatureStats2/CreatureAtk").text = "Atk " + String(creature.stat[6]);
	creatureData.get_node("CreatureStats2/CreatureSpAtk").text = "SpAtk " + String(creature.stat[7]);
	creatureData.get_node("CreatureStats2/CreatureSpd").text = "Spd "+ String(creature.stat[10]) ;
	
	creatureData.get_node("CreatureStats3/CreatureDef").text = "Def " + String(creature.stat[8]) ;
	creatureData.get_node("CreatureStats3/CreatureSpDef").text = "SpDef " + String(creature.stat[9]);
	
	var creatureMove = [creatureMove1, creatureMove2, creatureMove3, creatureMove4 ] ;
	
	for m in creature.moveList.size() :
		creatureMove[m].get_node("TypeSymbol/Sprite").texture = creature.moveList[m].elementType.elementTexture ;
		creatureMove[m].get_node("MoveInfo/MoveName").text = creature.moveList[m].skillName ;
		creatureMove[m].get_node("MoveInfo/MoveResource").text = String(creature.moveList[m].resourceType.resourceName) + " " + String(creature.moveList[m].resourceCost) ;
		
		if creature.moveList[m].move == 0:
			creatureMove[m].get_node("MoveInfo/MoveType").text = "Physical" ;
			creatureMove[m].get_node("MoveInfo/MovePotency").text = "Potency " + String(creature.moveList[m].potency) ;
		elif creature.moveList[m].move == 1:
			creatureMove[m].get_node("MoveInfo/MoveType").text = "Special" ;
			creatureMove[m].get_node("MoveInfo/MovePotency").text = "Potency " + String(creature.moveList[m].potency) ;
		else :
			creatureMove[m].get_node("MoveInfo/MoveType").text = "Status" ;
			creatureMove[m].get_node("MoveInfo/MovePotency").text = "Potency ----" ;
		

		creatureMove[m].get_node("Tooltip").text = creature.moveList[m].tool_tip ;



func resetPlayerMenu():
	creatureData.get_node("CreatureSprite/Sprite").texture = null ;
	creatureData.get_node("CreatureSprite/Sprite").frame = 0 ;
	
	creatureData.get_node("CreatureType/Type1Name").text = "";
	creatureData.get_node("CreatureType/Type2Name").text = "";
	
	creatureData.get_node("CreatureInfo/CreatureName").text = "";
	creatureData.get_node("CreatureInfo/CreatureLv").text = "";
	creatureData.get_node("CreatureInfo/CreatureExp").text = "" ;
	
	creatureData.get_node("CreatureStats1/CreatureHP").text = "" ;
	creatureData.get_node("CreatureStats1/CreatureEnergy").text = "";
	creatureData.get_node("CreatureStats1/CreatureResource").text =  "" ;
	
	creatureData.get_node("CreatureStats2/CreatureAtk").text =  "" ;
	creatureData.get_node("CreatureStats2/CreatureSpAtk").text =  "" ;
	creatureData.get_node("CreatureStats2/CreatureSpd").text =  "" ;
	
	creatureData.get_node("CreatureStats3/CreatureDef").text =  "" ;
	creatureData.get_node("CreatureStats3/CreatureSpDef").text =  "" ;
	
	creatureMove1.get_node("TypeSymbol/Sprite").texture = null ;
	creatureMove1.get_node("MoveInfo/MoveName").text = "" ;
	creatureMove1.get_node("MoveInfo/MoveResource").text = "" ;
	creatureMove1.get_node("MoveInfo/MoveType").text = "" ;
	creatureMove1.get_node("MoveInfo/MovePotency").text = "" ;
	creatureMove1.get_node("Tooltip").text = "" ;
	
	creatureMove2.get_node("TypeSymbol/Sprite").texture = null ;
	creatureMove2.get_node("MoveInfo/MoveName").text = "" ;
	creatureMove2.get_node("MoveInfo/MoveResource").text = "" ;
	creatureMove2.get_node("MoveInfo/MoveType").text = "" ;
	creatureMove2.get_node("MoveInfo/MovePotency").text = "" ;
	creatureMove2.get_node("Tooltip").text = "" ;
	
	creatureMove3.get_node("TypeSymbol/Sprite").texture = null ;
	creatureMove3.get_node("MoveInfo/MoveName").text = "" ;
	creatureMove3.get_node("MoveInfo/MoveResource").text = "" ;
	creatureMove3.get_node("MoveInfo/MoveType").text = "" ;
	creatureMove3.get_node("MoveInfo/MovePotency").text = "" ;
	creatureMove3.get_node("Tooltip").text = "" ;
	
	creatureMove4.get_node("TypeSymbol/Sprite").texture = null ;
	creatureMove4.get_node("MoveInfo/MoveName").text = "" ;
	creatureMove4.get_node("MoveInfo/MoveResource").text = "" ;
	creatureMove4.get_node("MoveInfo/MoveType").text = "" ;
	creatureMove4.get_node("MoveInfo/MovePotency").text = "" ;
	creatureMove4.get_node("Tooltip").text = "" ;


func _on_Player_updateCreatureMenu(creature):
	updatePlayerMenu(creature) ;
