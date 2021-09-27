extends Control


signal loadScene(scene) ;

#Scene Notes:
#Fade in must go on bottom so that covers everything
#set buttons mouse filter to pass, so that it can be pressed through fade in node

func _ready():
	$Margin/VBox/HBox/VBox2.get_child(0).grab_focus() ;
	for buttons in $Margin/VBox/HBox/VBox2.get_children():
		buttons.connect("pressed", self, "SceneSelect", [buttons.scene_to_load]) ;
		#not sure why this needs to be in brackets, i think because connect() needs it to be an array, even if single value



func SceneSelect(scene_to_load):
	$FadeInRect/FadeIn.play("fade_in") ;
	yield($FadeInRect/FadeIn, "animation_finished") ;
	emit_signal("loadScene", scene_to_load) ;
