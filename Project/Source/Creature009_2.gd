extends Node2D

enum STAT {
	MAX_HP,
	HP,
	MAX_ENERGY,
	ENERGY, 
	MAX_RESOURCE, 
	RESOURCE,
	ATK, 
	SPATK, 
	DEF, 
	SPDEF, 
	SPD
	} ;

var stat = [25,25,50,0,2,0,10,10,10,10,10];
var stat_mult = [1,1,1,1,1,1,1,1,1,1,1] ;

var moveList = ["Stare Down", "Razor Fin", "Scratch"] ;
