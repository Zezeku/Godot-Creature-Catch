extends KinematicBody2D


export (Texture) var spriteSheet ;
export (String) var dialogue ;
export (Resource) var item_to_give ;

var itemGiven = false ;
var isActive = false ;

func _ready():
	$Sprite.texture = spriteSheet ;
	$Sprite.centered = false ;
	$Sprite.offset = Vector2(-7, -21) ;
	$DialogueX.dialogue = dialogue ;


func _input(event):
	if event.is_action_pressed("ui_accept") and isActive and !($DialogueX.isActive):
		$DialogueX.ActivateDialogue(get_global_transform_with_canvas()) ;
		if !itemGiven:
			$DialogueX.dialogue = "I hope you got some use out of it." ;
			get_node("../../../Player/Inventory").addItem(item_to_give, 1);
			itemGiven = true ;
	elif event.is_action_pressed("ui_accept") and isActive and $DialogueX.isActive:
		$DialogueX.DeactivateDialogue() ;

func _on_Collision_body_entered(body):
	if body.name == "PlayerController":
#		$DialogueX.ActivateDialogue(get_global_transform_with_canvas()) ;
		isActive = true ;


func _on_Collision_body_exited(body):
		if body.name == "PlayerController":
			isActive = false ;
#			$DialogueX.DeactivateDialogue()
