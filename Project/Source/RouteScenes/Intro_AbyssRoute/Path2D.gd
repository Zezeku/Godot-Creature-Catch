extends Path2D

var rng = RandomNumberGenerator.new() ;

func _ready():
	
	rng.randomize() ;
	$PathFollow2D.set_offset(rng.randf_range(0,4)) ;
	
	

func _physics_process(delta):
	$PathFollow2D.set_offset($PathFollow2D.get_offset()+5*delta) ;
