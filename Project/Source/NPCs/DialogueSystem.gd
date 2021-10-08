extends Control


func connectToNodes() :
	var dialogues = get_tree().get_nodes_in_group("DialogueNodes") ;
	for d in dialogues.size():
		if !dialogues[d].is_connected("activateDialogue", self, "activateDialogue"):
			dialogues[d].connect("activateDialogue", self, "activateDialogue") ;
		if !dialogues[d].is_connected("deactivateDialogue", self, "deactivateDialogue"):
			dialogues[d].connect("deactivateDialogue", self, "deactivateDialogue") ;

#using canvas layer for dialogue ok
#but consider avoiding for messenger so that pop up doesnt move with camera
#should stay anchored to NPC
func activateDialogue(text, _location):
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

func activateMessage(_text):
	pass;
	
func deactivateMessage(_text):
	pass;
