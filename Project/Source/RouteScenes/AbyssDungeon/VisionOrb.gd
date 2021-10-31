extends StaticBody2D


export (bool) var isOn ;

func _ready():
	$OrbColor.frame = isOn ;
