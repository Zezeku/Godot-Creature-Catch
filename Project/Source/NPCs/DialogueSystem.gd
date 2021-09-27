extends Control


func connectToNodes() :
	var dialogues = get_tree().get_nodes_in_group("DialogueNodes") ;
	for d in dialogues.size():
		dialogues[d].connect("activateDialogue", self, "activateDialogue") ;
		dialogues[d].connect("deactivateDialogue", self, "deactivateDialogue") ;

#using canvas layer for dialogue ok
#but consider avoiding for messenger so that pop up doesnt move with camera
#should stay anchored to NPC
func activateDialogue(text, location):
	$CanvasLayer/Panel/Label.text = text ;
	#finds the sprite location on canvas screen and set panel position to it
	#$CanvasLayer/Panel.rect_position = location[2] ;
	#offset the panel based on its size to be above NPC
	#$CanvasLayer/Panel.rect_position += Vector2(-1 * $CanvasLayer/Panel.rect_size.x/2, -1 * $CanvasLayer/Panel.rect_size.y*1.5) ;
	$CanvasLayer/Panel.visible = true ;
	get_parent().playerPause.pausePlayerController() ;


func deactivateDialogue():
	$CanvasLayer/Panel/Label.text = "" ;
	$CanvasLayer/Panel.visible = false ;
	get_parent().playerPause.unpausePlayerController() ;

func activateMessage(text):
	pass;
	
func deactivateMessage(text):
	pass;
