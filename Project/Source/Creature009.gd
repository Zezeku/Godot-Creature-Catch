extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var HP = 25 ;
var curHP = 25 ;
var Energy = 50 ;
var Aether = 2 ;

var Atk = 15 ;
var SpAtk = 10 ;
var Def = 17 ;
var SpDef = 10 ;
var Spd = 10 ;

var stat_changes = [1,1,1,1,1] ;

var moveSet = ["Stare Down", "Razor Fin", "Scratch"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
