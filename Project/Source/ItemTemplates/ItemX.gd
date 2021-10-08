extends Node2D

var itemName ;

var itemData ;
var itemEffects = [] ;

func initialize(item):
	itemData = item ;
	itemData.initialize(self) ;
	

func execute(source, target, state):
	yield(itemData.execute(source, target, state), "completed") ;
