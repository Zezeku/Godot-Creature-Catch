extends Button

var item_key ;

signal item_pressed(item_key) ;



func _on_ItemButtonX_pressed():
	emit_signal("item_pressed", item_key) ;
