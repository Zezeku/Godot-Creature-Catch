extends Resource

class_name ResourceTemplate

export(String) var resourceName
export(PackedScene) var resourceGUI
export(bool) var isRage

func initialize(creature):
	creature.resourceType = self
	if isRage:
		creature.stat[creature.STAT.RESOURCE] = 0 ;
#creature.resourceGUI = GUI.instance() need to make GUI scene for each resource to display info. this gets added to UI
#creature.resourceGUI.initialize(creture.stats[creature.maxResource])

#i have notes asking if this is unneccessary. Either it didnt work, or i had built in other place and was afraid to breka it
#func updateResource(creature, resourceCost)
#creature.stats[creature.resourceType]
#unit.resourceGUI.updateResource(creature, resourceCost)
