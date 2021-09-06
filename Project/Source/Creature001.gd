extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var HP = 25 ;
var curHP = 25 ;
var Energy = 50 ;
var Rage = 20 ;

var Atk = 15 ;
var SpAtk = 15 ;
var Def = 15 ;
var SpDef = 15 ;
var Spd = 10 ;

var stat_changes = [1,1,1,1,1] ;

var moveSet = ["Scratch", "Bark Jab", "Sediment Trap"]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
