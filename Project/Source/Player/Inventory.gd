extends Node2D

var itemX = load("res://Source/ItemTemplates/ItemX.tscn") ;

onready var inv_dict = {} ;

func addItem(item_name, qty):
	if inv_dict.has(item_name):
		inv_dict[item_name] += qty ; 
	else:
		inv_dict[item_name] = qty ;
	

func useItem(item, source, target, state):
	
	var item_to_use = itemX.instance() ;
	item_to_use.initialize(item)
	
	yield(item_to_use.execute(source, target, state), "completed") ;
	
	removeItem(item, item_to_use) ;

func removeItem(item, item_used):
	inv_dict[item] -= 1 ;
	if inv_dict[item] <=0:
		inv_dict.erase(item) ;
	item_used.queue_free() ;

func getItemQty(item_name):
	return inv_dict[item_name] ;
