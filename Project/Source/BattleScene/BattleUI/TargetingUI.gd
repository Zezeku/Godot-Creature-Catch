extends Control

onready var playerCreature1 = null ;
onready var playerCreature2 = null ;
onready var enemyCreature1 = null ;
onready var enemyCreature2 = null ;


#also it need a swapped out creature method, that discconects to current creature, and conects to new creature
#no instanced GUI liks playerUI, so dont need to clear anything out

func DisplayTargetingUI(player1, player2, enemy1, enemy2):
	
	playerCreature1 = player1 ;
	playerCreature2 = player2 ;
	enemyCreature1 = enemy1 ;
	enemyCreature2 = enemy2 ;
	
	if playerCreature1 != null:
		playerCreature1.connect("UpdateTargetingUI_Fainted", self, "UpdateTargetingUI_Fainted") ;
		
		$PlayerCreature1/Sprite.texture = playerCreature1.get_child(0).texture ;
		$PlayerCreature1/Sprite.hframes = playerCreature1.get_child(0).hframes ;
		$PlayerCreature1/Sprite.vframes = playerCreature1.get_child(0).vframes ;
		$PlayerCreature1/Sprite.frame = 2 ;
		
		$PlayerCreature1.rect_scale = Vector2(3,3) ;
		$PlayerCreature1.visible = true ;
		$PlayerCreature1.rect_position = Vector2(500,500) ;
	
	if playerCreature2 != null:
		
		playerCreature2.connect("UpdateTargetingUI_Fainted", self, "UpdateTargetingUI_Fainted") ;
		
		$PlayerCreature2/Sprite.texture = playerCreature2.get_child(0).texture ;
		$PlayerCreature2/Sprite.hframes = playerCreature2.get_child(0).hframes ;
		$PlayerCreature2/Sprite.vframes = playerCreature2.get_child(0).vframes ;
		$PlayerCreature2/Sprite.frame = 2 ;
		
		$PlayerCreature2.rect_scale = Vector2(3,3) ;
		$PlayerCreature2.visible = true ;
		$PlayerCreature2.rect_position = Vector2(700,650) ;
		
	
	if enemyCreature1 != null:
		enemyCreature1.connect("UpdateTargetingUI_Fainted", self, "UpdateTargetingUI_Fainted") ;
		
		$EnemyCreature1/Sprite.texture = enemyCreature1.get_child(0).texture ;
		$EnemyCreature1/Sprite.hframes = enemyCreature1.get_child(0).hframes ;
		$EnemyCreature1/Sprite.vframes = enemyCreature1.get_child(0).vframes ;
		$EnemyCreature1/Sprite.frame = 0 ;
		
		$EnemyCreature1.rect_scale = Vector2(2,2) ;
		$EnemyCreature1.visible = true ;
		$EnemyCreature1.rect_position = Vector2(800,250) ;
	
	if enemyCreature2 != null:
		
		enemyCreature2.connect("UpdateTargetingUI_Fainted", self, "UpdateTargetingUI_Fainted") ;
		
		$EnemyCreature2/Sprite.texture = enemyCreature2.get_child(0).texture ;
		$EnemyCreature2/Sprite.hframes = enemyCreature2.get_child(0).hframes ;
		$EnemyCreature2/Sprite.vframes = enemyCreature2.get_child(0).vframes ;
		$EnemyCreature2/Sprite.frame = 0 ;
		
		$EnemyCreature2.rect_scale = Vector2(2,2) ;
		$EnemyCreature2.visible = true ;
		$EnemyCreature2.rect_position = Vector2(1050,350) ;

func ActivateTargetingUI(targets, target_select):
	#for multiple targets, may skip button functionality in general
	match target_select:
		1:
			for target in targets:
				if target == playerCreature1:
					$PlayerCreature1.disabled = false ;
					$PlayerCreature1.focus_mode = Control.FOCUS_ALL ;
				elif target == playerCreature2:
					$PlayerCreature2.disabled = false ;
					$PlayerCreature2.focus_mode = Control.FOCUS_ALL ;
				elif target == enemyCreature1:
					$EnemyCreature1.disabled = false ;
					$EnemyCreature1.focus_mode = Control.FOCUS_ALL ;
				elif target == enemyCreature2:
					$EnemyCreature2.disabled = false ;
					$EnemyCreature2.focus_mode = Control.FOCUS_ALL ;
				else:
					print("error") ;
	
	for child in get_children():
		if child.disabled == false:
			if child.get_index() == 0 or child.get_index() == 1:
				child.get_child(0).frame = 3 ;
			else:
				child.get_child(0).frame = 1 ;
			child.grab_focus() ;
			break ;
	
	


func ActivatePlayerTargetingUI(creature):
	if creature == playerCreature1:
		$PlayerCreature1/Sprite.frame = 3 ;
	else:
		$PlayerCreature2/Sprite.frame = 3 ;
	

func UpdateTargetingUI_Fainted(creature):
	
	if creature == playerCreature1:
		playerCreature1 = null ;
		$PlayerCreature1.visible = false ;
		$PlayerCreature1.disabled = true ;
		$PlayerCreature1.focus_mode = Control.FOCUS_NONE ;
	elif creature == playerCreature2:
		playerCreature2 = null ;
		$PlayerCreature2.visible = false ;
		$PlayerCreature2.disabled = true ;
		$PlayerCreature2.focus_mode = Control.FOCUS_NONE ;
	elif creature == enemyCreature1:
		enemyCreature1 = null ;
		$EnemyCreature1.visible = false ;
		$EnemyCreature1.disabled = true ;
		$EnemyCreature1.focus_mode = Control.FOCUS_NONE ;
	else:
		enemyCreature2 = null ;
		$EnemyCreature2.visible = false ;
		$EnemyCreature2.disabled = true ;
		$EnemyCreature2.focus_mode = Control.FOCUS_NONE ;
	
	

func UpdateTargetingUI_Switch(creature, index):
	if index == 0:
		playerCreature1 = creature ;
		playerCreature1.connect("UpdateTargetingUI_Fainted", self, "UpdateTargetingUI_Fainted") ;
		$PlayerCreature1/Sprite.texture = playerCreature1.get_child(0).texture ;
		$PlayerCreature1/Sprite.hframes = playerCreature1.get_child(0).hframes ;
		$PlayerCreature1/Sprite.vframes = playerCreature1.get_child(0).vframes ;
		$PlayerCreature1/Sprite.frame = 2 ;
		
		$PlayerCreature1.rect_scale = Vector2(3,3) ;
		$PlayerCreature1.visible = true ;
		$PlayerCreature1.rect_position = Vector2(500,500) ;
	else:
		playerCreature2 = creature ;
		playerCreature2.connect("UpdateTargetingUI_Fainted", self, "UpdateTargetingUI_Fainted") ;
		
		$PlayerCreature2/Sprite.texture = playerCreature2.get_child(0).texture ;
		$PlayerCreature2/Sprite.hframes = playerCreature2.get_child(0).hframes ;
		$PlayerCreature2/Sprite.vframes = playerCreature2.get_child(0).vframes ;
		$PlayerCreature2/Sprite.frame = 2 ;
		
		$PlayerCreature2.rect_scale = Vector2(3,3) ;
		$PlayerCreature2.visible = true ;
		$PlayerCreature2.rect_position = Vector2(700,650) ;

func HideTargetingUI():
	$PlayerCreature1.disabled = true ;
	$PlayerCreature2.disabled = true ;
	$EnemyCreature1.disabled = true;
	$EnemyCreature2.disabled = true ;
	
	$PlayerCreature1.focus_mode = Control.FOCUS_NONE ;
	$PlayerCreature2.focus_mode = Control.FOCUS_NONE ;
	$EnemyCreature1.focus_mode = Control.FOCUS_NONE ;
	$EnemyCreature2.focus_mode = Control.FOCUS_NONE ;
	
	#frame 2 only exists if the player creature exists
	if playerCreature1 != null:
		$PlayerCreature1/Sprite.frame = 2 ;
	if playerCreature2 != null:
		$PlayerCreature2/Sprite.frame = 2 ;
	$EnemyCreature1/Sprite.frame = 0 ;
	$EnemyCreature2/Sprite.frame = 0 ;
	
	
func _on_PlayerCreature1_pressed():
	HideTargetingUI() ;
	get_node("../BattleUIHandler").TargetSelect(playerCreature1) ;


func _on_PlayerCreature2_pressed():
	HideTargetingUI() ;
	get_node("../BattleUIHandler").TargetSelect(playerCreature2) ;


func _on_EnemyCreature1_pressed():
	HideTargetingUI() ;
	get_node("../BattleUIHandler").TargetSelect(enemyCreature1) ;


func _on_EnemyCreature2_pressed():
	HideTargetingUI() ;
	get_node("../BattleUIHandler").TargetSelect(enemyCreature2) ;


func _on_EnemyCreature1_focus_entered():
	$EnemyCreature1/Sprite.frame = 1 ;


func _on_EnemyCreature2_focus_entered():
	$EnemyCreature2/Sprite.frame = 1 ;

func _on_EnemyCreature1_focus_exited():
	$EnemyCreature1/Sprite.frame = 0 ;


func _on_EnemyCreature2_focus_exited():
	$EnemyCreature2/Sprite.frame = 0 ;

func _on_EnemyCreature1_mouse_entered():
	if $EnemyCreature1.focus_mode == Control.FOCUS_ALL:
		$EnemyCreature1.grab_focus() ;


func _on_EnemyCreature2_mouse_entered():
	if $EnemyCreature2.focus_mode == Control.FOCUS_ALL:
		$EnemyCreature2.grab_focus() ;



func _on_PlayerCreature1_focus_entered():
	$PlayerCreature1/Sprite.frame = 3 ;


func _on_PlayerCreature1_focus_exited():
	$PlayerCreature1/Sprite.frame = 2 ;


func _on_PlayerCreature1_mouse_entered():
	if $PlayerCreature1.focus_mode == Control.FOCUS_ALL:
		$PlayerCreature1.grab_focus() ;


func _on_PlayerCreature2_focus_entered():
	$PlayerCreature2/Sprite.frame = 3 ;


func _on_PlayerCreature2_focus_exited():
	$PlayerCreature2/Sprite.frame = 2 ;


func _on_PlayerCreature2_mouse_entered():
	if $PlayerCreature2.focus_mode == Control.FOCUS_ALL:
		$PlayerCreature2.grab_focus() ;
