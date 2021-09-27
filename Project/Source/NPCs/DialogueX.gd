extends Node2D


var dialogue = "" ;
var message = "";
var isActive = false ;

signal activateDialogue(text) ;
signal deactivateDialogue() ;


#player is stopped during these dialogues
func ActivateDialogue(location):
	isActive = true ;
	emit_signal("activateDialogue", dialogue, location) ;

func DeactivateDialogue():
	isActive = false ;
	emit_signal("deactivateDialogue") ;

#player is not stopped during these pop up messages
func ActivateMessage():
	pass
