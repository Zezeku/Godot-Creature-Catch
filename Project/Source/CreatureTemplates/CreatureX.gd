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

var creatureData ;
var creatureName ;
var creatureNickname ;

var level ;
var experience: int ;
var experience_needed: int ;
var experience_given: int ;

var spriteSheet ;
var resourceType ;
var creatureType ;

var stat = [null,null,null,null,null,null,null,null,null,null,null]
var stat_mult = [null,null,null,null,null,null,null,null,null,null,null]

var moveList = [] ;

var moveEffects = [] ; #this will keep track of effects such as poison

func initializeStats(creature, set_level) : #the creature manager will handle this
	creatureData = creature ;
	creatureData.initialize(self, set_level) ;
	stat_mult = [1,1,1,1,1,1,1,1,1,1,1] ;
	level=set_level ;
	experience = 0 ;
	experience_needed = 6 * pow(( 1 + 0.20), level) ;
	experience_given = 6 * pow(( 1 + 0.20), level) /2 ; 
	self.visible = false ;

func levelUp():
	level += 1 ;
	var cur_exp = experience - experience_needed ;
	experience_needed = 6 * pow(( 1 + 0.20), level) ;
	experience_given = 6 * pow(( 1 + 0.20), level) /2; 
	experience = cur_exp ;
	creatureData.levelUp(self, level) ;
	
	
	
