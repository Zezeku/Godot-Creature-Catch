extends Node2D

onready var LavalCliffs = get_node("Route1-LowerCliffs") ;


func LavaCliffsOn():
	LavalCliffs.set_collision_layer_bit(0,true) ;
	LavalCliffs.set_collision_mask_bit(0,true) ;

func LavaCliffsOff():
	
	LavalCliffs.set_collision_layer_bit(0,false) ;
	LavalCliffs.set_collision_mask_bit(0,false) ;


func _on_Bridge2D_body_entered(_body):
	LavaCliffsOff()

func _on_Bridge2D2_body_entered(_body):
	LavaCliffsOff()


func _on_Bridge2D_body_exited(_body):
	LavaCliffsOn()


func _on_Bridge2D2_body_exited(_body):
	LavaCliffsOn()
