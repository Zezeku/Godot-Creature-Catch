extends Area2D

onready var startNet = load("res://Source/ItemTemplates/StarterNet.tres") ;
onready var itemX = load("res://Source/ItemTemplates/ItemX.tscn") ;


var active = false ;
var itemGiven = false ;
signal healParty ;


func _input(event):
	if event.is_action_pressed("ui_accept") and active:
			emit_signal("healParty") ;
			if !itemGiven:
				get_node("../Panel").visible = true ;
				var item = itemX.instance() ;
				item.initialize(startNet) ;
				get_node("../../../../Player/Inventory").inventory.append(item) ;
				get_node("../../../../Player/Inventory").inventory_amount.append(1) ;
				itemGiven = true ;
			else:
				get_node("../Panel3").visible = true ;

func _on_DialougeArea_body_entered(body):
	if body.name == "PlayerController":
		get_node("../Panel2").visible = false ;
		active = true ;


func _on_DialougeArea_body_exited(body):
	if body.name == "PlayerController":
		get_node("../Panel").visible = false ;
		get_node("../Panel3").visible = false ;
		active = false ;
