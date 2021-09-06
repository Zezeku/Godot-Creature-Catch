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
	var damage = 3 ;
	damageCalc(target, damage) ;

func SedimentTrap(source, target):
	pass

func BarkJab(source, target):
	var damage = 6 ;
	damageCalc(target, damage) ;

func StareDown(source, target):
	pass

func RazorFin(source, target):
	var damage = 6 ;
	damageCalc(target, damage) ;

func damageCalc(source, damage):
	source.curHP -= damage ;
