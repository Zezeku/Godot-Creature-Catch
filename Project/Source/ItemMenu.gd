extends PopupPanel

var itemSelection ;
signal itemSelected(itemSelect) ;

func displayItems(items, items_amount):
	
	for i in items.size():
		$ItemGrid/Item1.text = String(items[i].itemName) + "  x " + String(items_amount[0]) ;
	
	visible = true ;
	

func resetButtons():
	visible = false ;




func _on_Item1_pressed():
	itemSelection = 0 ;
	resetButtons() ;
	emit_signal("itemSelected", itemSelection) ;
