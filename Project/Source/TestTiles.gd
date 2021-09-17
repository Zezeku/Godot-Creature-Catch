extends Node2D

onready var LavalCliffs = get_node("Route1-LowerCliffs") ;

func _ready():
		get_node("../YSort/BridgeSort/Bridge/Bridge2D").connect("LavaCliffsOff", self, "LavaCliffsOff") ;
		get_node("../YSort/BridgeSort/Bridge/Bridge2D").connect("LavaCliffsOn", self, "LavaCliffsOn") ;
		get_node("../YSort/BridgeSort/Bridge2/Bridge2D").connect("LavaCliffsOff", self, "LavaCliffsOff") ;
		get_node("../YSort/BridgeSort/Bridge2/Bridge2D").connect("LavaCliffsOn", self, "LavaCliffsOn") ;
	


func LavaCliffsOn():
	LavalCliffs.set_collision_layer_bit(0,true) ;
	LavalCliffs.set_collision_mask_bit(0,true) ;

func LavaCliffsOff():
	
	LavalCliffs.set_collision_layer_bit(0,false) ;
	LavalCliffs.set_collision_mask_bit(0,false) ;
