extends YSort


const ENCOUNTER_RATE = 0.1 ;

func IsEncounter():
	var rng = RandomNumberGenerator.new() ;
	rng.randomize() ;
	var randomNumber = rng.randf_range(0, 1) ;
	if randomNumber <= ENCOUNTER_RATE:
		get_parent().get_parent().get_parent().isEncounter() ;
