extends Area2D

onready var startNet = load("res://Source/ItemTemplates/StarterNet.tres") ;
onready var itemX = load("res://Source/ItemTemplates/ItemX.tscn") ;


var active = false ;
var itemGiven = false ;
signal healParty ;

func _ready():
	pass # Replace with function body.



func _input(event):
	if event.is_action_pressed("ui_accept") and active:
		#pause the tree and let this process
		#dont let player do action while this is happening
		#figure out player loc and frame to determine if looking at npc
		# x> & y<, x> and y>, etc.. and frame is 0 thru 4, ... etc.
		if get_node("../Panel").visible == false :
			get_node("../Panel").visible = true ;
			emit_signal("healParty") ;
			if !itemGiven:
				var item = itemX.instance() ;
				item.initialize(startNet) ;
				get_node("../../../../Player/Inventory").inventory.append(item) ;
				get_node("../../../../Player/Inventory").inventory_amount.append(1) ;
				print("You got ", item.itemName, " !") ;
				itemGiven = true ;
		else:
			get_node("../Panel").visible = false ;

func _on_DialougeArea_body_entered(body):
	if body.name == "PlayerController":
		get_node("../Panel2").visible = false ;
		active = true ;


func _on_DialougeArea_body_exited(body):
	if body.name == "PlayerController":
		active = false ;
		get_node("../Panel").visible = false ;
