extends KinematicBody2D


export (Texture) var spriteSheet ;
export (String) var dialogue ;
export (String) var dialogue2 ;
export (Resource) var item_to_give ;

var itemGiven = false ;
var isActive = false ;

func _ready():
	$Sprite.texture = spriteSheet ;
	$Sprite.centered = false ;
	$Sprite.offset = Vector2(-7, -21) ;
	$DialogueX.dialogue = dialogue ;
	



func _input(event):
	#logic breaks if reentered scene
	if event.is_action_pressed("ui_accept") and isActive and !($DialogueX.isActive):
		
		if itemGiven:
			$DialogueX.dialogue = dialogue2;
		
		$DialogueX.ActivateDialogue(get_global_transform_with_canvas()) ;
		
		if !itemGiven:
			get_node("../../../Player/Inventory").addItem(item_to_give, 2);
			itemGiven = true ;
			get_parent().get_parent().my_route_dict[self.name] = itemGiven ;
			
	elif event.is_action_pressed("ui_accept") and $DialogueX.isActive:
		$DialogueX.DeactivateDialogue() ;
	

func _on_Collision_body_entered(body):
	if body.name == "PlayerController":
#		$DialogueX.ActivateDialogue(get_global_transform_with_canvas()) ;
		isActive = true ;


func _on_Collision_body_exited(body):
		if body.name == "PlayerController":
			isActive = false ;
#			$DialogueX.DeactivateDialogue()
