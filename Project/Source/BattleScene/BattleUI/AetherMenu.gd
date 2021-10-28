extends PopupPanel

onready var AetherLabel = get_node("VBox/AetherLabel") ;
onready var TargetLabel = get_node("VBox/HBox/TargetLabel") ;
onready var TargetButton = get_node("VBox/HBox/TargetAether") ;

onready var ActiveShow = get_node("VBox/HBox2") ;
onready var ActiveAether = get_node("VBox/HBox2/ActiveAetherLabel") ;
onready var ActiveButton = get_node("VBox/HBox2/ActiveAether") ;

var aether_creature ;
var aether_target ;
var aether_move ;

var aether_myActiveEffect ;
var aether_redistribute = [] ;

func DisplayAetherMenu(creature, target, move):
	
	aether_creature = creature ;
	aether_target = target ;
	aether_move = move ;
	
	
	visible = true ;
	AetherLabel.text = "Aether Available: " + String(creature.stat[creature.STAT.RESOURCE]) ;
	TargetLabel.text = String(target.creatureName) + ", " + String(move.skillName) ;
	TargetButton.text = "Use " + String(move.resourceCost) + " Aether" ;
	
	if creature.targetEffects.size() > 0:
		var myActiveEffect = creature.targetEffects[0] ;
		aether_myActiveEffect = myActiveEffect ; #for testing
		ActiveAether.text = String(myActiveEffect.my_target.creatureName) + "," + String(myActiveEffect.my_skill.skillName) ;
		ActiveButton.text = "Collect " + String(myActiveEffect.my_skill.resourceCost) + " Aether" ;
		ActiveShow.visible = true ;
		ActiveButton.grab_focus() ;
	
	if creature.stat[creature.STAT.RESOURCE] >= move.resourceCost:
		TargetButton.disabled = false ;
		TargetButton.grab_focus() ;

func ResetAetherMenu():
	AetherLabel.text = "" ;
	
	TargetLabel.text = "" ;
	TargetButton.text = "" ;
	TargetButton.disabled = true ;
	
	ActiveAether.text = "" ;
	ActiveButton.text = "" ;
	ActiveButton.pressed = false ;
	ActiveShow.visible = false ;
	
	aether_creature = null ;
	aether_target = null ;
	aether_move = null ;
	aether_myActiveEffect = null ;
	aether_redistribute = [] ;
	
	visible = false ;

func _on_TargetAether_pressed():
	
	print("setting resourceToDistribute to: ", aether_redistribute )
	aether_creature.resourceToDistribute = aether_redistribute.duplicate() ;
	
	ResetAetherMenu() ;
	
	get_node("../BattleUIHandler").AetherDistribute() ;

#will definitely need to follow similar strategy as items, for custom signal
func _on_ActiveAether_toggled(button_pressed):
	if button_pressed:
		if aether_myActiveEffect:
			
			AetherLabel.text = "Aether Available: " + String(aether_creature.stat[aether_creature.STAT.RESOURCE] + aether_myActiveEffect.my_skill.resourceCost) ;
			aether_redistribute.append(aether_myActiveEffect) ;
			
			if aether_creature.stat[aether_creature.STAT.RESOURCE] + aether_myActiveEffect.my_skill.resourceCost >= aether_move.resourceCost:
				TargetButton.disabled = false ;
			
	else:
		AetherLabel.text = "Aether Available: " + String(aether_creature.stat[aether_creature.STAT.RESOURCE]) ;
		
		if aether_myActiveEffect:
			aether_redistribute.erase(aether_myActiveEffect) ;
		
		if aether_creature.stat[aether_creature.STAT.RESOURCE] < aether_move.resourceCost:
				TargetButton.disabled = true ;
