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
	var damage = clamp(source.stat[source.STAT.ATK] * (1 + potency / 100) * source.stat_mult[source.STAT.ATK] - target.stat[target.STAT.DEF] * target.stat_mult[source.STAT.DEF],1,target.stat[target.STAT.HP]) ;
	
	print(source.name, " used Scratch on ", target.name, " and did ", damage, " damage!");
	damageCalc(source, target, damage) ;

func SedimentTrap(source, target):
	var multiplier = -0.1 ;
	
	print(source.name, " used Sediment Trap on ", target.name, " and lowered its Speed!") ;
	target.stat_mult[target.STAT.SPD] += multiplier;

func BarkJab(source, target):
	var potency = 40 ;
	var damage = clamp(source.stat[source.STAT.ATK] * (1 + potency / 100) * source.stat_mult[source.STAT.ATK] - target.stat[target.STAT.DEF] * target.stat_mult[source.STAT.DEF],1,target.stat[target.STAT.HP]) ;
	
	print(source.name, " used Bark Jab on ", target.name, " and did ", damage, " damage!");
	damageCalc(source, target, damage) ;

func StareDown(source, target):
	var multiplier = -0.1 ;
	
	print(source.name, " used Stare Down on ", target.name, " and lowered its Defense!") ;
	target.stat_mult[target.STAT.DEF] += multiplier ;

func RazorFin(source, target):
	var potency = 40 ;
	var damage = clamp(source.stat[source.STAT.ATK] * (1 + potency / 100) * source.stat_mult[source.STAT.ATK] - target.stat[target.STAT.DEF] * target.stat_mult[source.STAT.DEF],1,target.stat[target.STAT.HP]) ;
	
	print(source.name, " used Razor Fin on ", target.name, " and did ", damage, " damage!");
	damageCalc(source, target, damage) ;

func damageCalc(source, target, damage):
	target.stat[source.STAT.HP] -= clamp(damage, 1, target.stat[target.STAT.HP]) ;
	if(target.stat[target.STAT.HP] <= 0):
		fainted(source, target) ;

func fainted(source, target):
	gainExp(source, target) ;
	var target_parent = target.get_parent() ;
	var targetIndex = target_parent.get_parent().battleTeam.find(target) ;
	target.visible = false ;
	target_parent.get_parent().battleTeam[targetIndex] = null ;
	#how to handle fainted creature?

func gainExp(source, target) :
	print(source.name, " gained ", target.experience_given, " exp!") ;
	source.experience += target.experience_given ;
	if(source.experience >= source.experience_needed):
		print(source.name, " grew to level ", (source.level+1), " !") ;
		source.levelUp() ;
