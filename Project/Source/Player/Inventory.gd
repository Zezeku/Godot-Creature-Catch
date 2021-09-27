extends Node2D

var itemX = load("res://Source/ItemTemplates/ItemX.tscn") ;

onready var inventory = [] ;
onready var inventory_amount = [] ;

onready var inv_dict = {} ;

func addItem(item_name, qty):
	if inv_dict.has(item_name):
		inv_dict[item_name] += qty ; 
	else:
		inv_dict[item_name] = qty ;
	

func useItem(item, source, target):
	
	var item_to_use = itemX.instance() ;
	item_to_use.initialize(item)
	
	item_to_use.execute(source, target) ;
	
	removeItem(item, item_to_use) ;

func removeItem(item, item_used):
	inv_dict[item] -= 1 ;
	if inv_dict[item] <=0:
		inv_dict.erase(item) ;
	item_used.queue_free() ;
