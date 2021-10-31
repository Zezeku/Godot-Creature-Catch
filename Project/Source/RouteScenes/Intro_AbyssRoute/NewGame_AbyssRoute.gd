extends Node2D

onready var templeStart_ypos = $TempleBackground.position.y + 5 + $TempleBackground/TempleTexture.rect_size.y / 2 ;

func _ready():
	set_process(false) ;
	initializePlayerController() ;
	$AbyssIntroCutscenes.play("Abyss_Intro") ;
	yield($AbyssIntroCutscenes, "animation_finished") ;

func _process(_delta):
	$TempleBackground/TempleTexture.rect_position.y = ($PlayerController.position.y - templeStart_ypos) * 0.85;
	print($TempleBackground/TempleTexture.rect_position.y)


func _on_ScrollTrigger_body_entered(body):
	if body.name == "PlayerController":
		scrollTempleBackground() ;

func scrollTempleBackground():
	set_process(true) ; 

func initializePlayerController():
	$PlayerController.setSpeed(25) ;
	$PlayerController.set_physics_process(false) ;
	$PlayerController/AnimationTree.active = false ;
	$PlayerController/Sprite.frame = 0 ;
	$PlayerController.position = Vector2.ZERO ;

func DisplayIntroText():
	$DialogueLayer/PopupDialog.visible = true ;

func startPlayerController():
	$PlayerController.set_physics_process(true) ;

func resetDialogue():
	$DialogueLayer/PopupDialog/VBoxContainer/CenterContainer/Label.text = "Remember, if you get lost in the abyss, it’s never too late to start the path before you. \nIt only requires the courage to take the first step." ;
	$DialogueLayer/PopupDialog.visible = true ;


func _on_PlayerBoundaries_body_exited(body):
	if body.name == "PlayerController":
		if !$AbyssIntroCutscenes.is_playing():
			$AbyssIntroCutscenes.play("Abyss_Reset") ;
