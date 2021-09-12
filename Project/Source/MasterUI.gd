extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BattleStart_ShowBattleStart(player, enemy):
	get_tree().paused = true ;
	var t = Timer.new() ;
	add_child(t) ;
	t.one_shot = true ;
	t.autostart = false ;
	
	$BattleBeginPopup.visible = true ;
	t.wait_time = 1 ;
	t.start() ;
	yield(t, "timeout") ;
	
	$BattleBeginPopup/BattleBegingsLabel.set_text(player.name + " VS " + enemy.name) ;
	t.wait_time = 1 ;
	t.start() ;
	yield(t, "timeout") ;
	t.queue_free() ;
	
	$BattleBeginPopup.visible = false ;
	get_tree().paused = false ;
