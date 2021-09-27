extends PopupPanel

onready var itemButton = load("res://Source/BattleScene/BattleUI/ItemButtonX.tscn") ;
signal item_select(item_key) ;

func DisplayItems(inv_dict):
	
	var inv_dict_array = Array(inv_dict.keys()) ;
	
	#inv_dict = {itemResource: qty, itemResource, qty, ..}
	#inv_dict = [itemResource, itemResource, ..]
	
	for key in inv_dict_array.size():
		var new_button = itemButton.instance() ;
		new_button.item_key = inv_dict_array[key]
		new_button.text = inv_dict_array[key].itemName + "  X " + String(inv_dict[inv_dict_array[key]]);
		
		$ItemGrid.add_child(new_button) ;
	
	for child in $ItemGrid.get_children():
		child.connect("item_pressed", self, "item_pressed") ;
	
	$ItemGrid.get_child(0).grab_focus() ;
	visible = true ;
	

func item_pressed(item_key):
	resetButtons() ;
	get_node("../BattleUIHandler").ItemSelect(item_key) ;

func resetButtons():
	for child in $ItemGrid.get_child_count():
		var my_child = $ItemGrid.get_child(child) ;
		$ItemGrid.remove_child(my_child) ;
		my_child.queue_free() ;
	
	visible = false ;

