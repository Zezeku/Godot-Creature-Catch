extends Node2D


onready var inventory = [] ;
onready var inventory_amount = [] ;

func useItem(item, source, target):
	
	inventory[item].execute(source, target) ;
	
	removeItem(item) ;

func removeItem(item):
	inventory_amount[item] -= 1 ;
	if inventory_amount[item] == 0 :
		inventory[item].queue_free() ;
		inventory.remove(item) ;
		inventory_amount.remove(item) ;
