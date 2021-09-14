extends Node2D

var itemName ;

var itemData ;
var itemEffects = [] ;

func initialize(item):
	itemData = item ;
	itemData.initialize(self) ;
	

func execute(source, target):
	itemData.execute(source, target) ;
