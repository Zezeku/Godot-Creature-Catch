extends Resource

class_name itemEffect

func execute(source, target, item):
	var rng = RandomNumberGenerator.new() ;
	rng.randomize() ;
	
	if rng.randf_range(0,1) <= item.catchRate:
		target.get_parent().remove_child(target) ;
		source.add_child(target) ;
		print("\nYou caught ", target.creatureName, " !!!") ;
	
	else:
		print(target.name, " escaped the net!") ;



