extends Node2D



func getMove(source, target, moveName):
	if moveName == "Scratch":
		Scratch(source, target) ;
	elif moveName == "Sediment Trap":
		SedimentTrap(source, target) ;
	elif moveName == "Bark Jab":
		BarkJab(source, target) ;
	elif moveName == "Razor Fin":
		RazorFin(source, target) ;
	elif moveName == "Stare Down":
		StareDown(source, target) ;
	else:
		print("N/A Error: Move does not exist") ;


func Scratch(source, target):
	var potency = 20 ;
	var damage = source.Atk * (1 + potency / 100) - target.Def ;
	
	print(source.name, " used Scratch on ", target.name, " and did ", damage, " damage!");
	damageCalc(target, damage) ;

func SedimentTrap(source, target):
	var multiplier = -0.1 ;
	
	print(source.name, " used Sediment Trap on ", target.name, " and lowered its Speed!") ;
	target.stat_changes[4] += multiplier;

func BarkJab(source, target):
	var potency = 40 ;
	var damage = source.Atk * (1 + potency / 100) * source.stat_changes[0] - target.Def * target.stat_changes[2] ;
	
	print(source.name, " used Bark Jab on ", target.name, " and did ", damage, " damage!");
	damageCalc(target, damage) ;

func StareDown(source, target):
	var multiplier = -0.1 ;
	
	print(source.name, " used Stare Down on ", target.name, " and lowered its Defense!") ;
	target.stat_changes[2] += multiplier ;

func RazorFin(source, target):
	var potency = 40 ;
	var damage = source.Atk * (1 + potency / 100) * source.stat_changes[0] - target.Def * target.stat_changes[2] ;
	
	print(source.name, " used Razor Fin on ", target.name, " and did ", damage, " damage!");
	damageCalc(target, damage) ;

func damageCalc(source, damage):
	source.curHP -= damage ;
