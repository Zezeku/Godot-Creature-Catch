extends Node2D

onready var player = $Player ;
onready var enemy = $Enemy ;


func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_parent().change_to_world_state() ;
	


func _on_BattleStart_PlayBattleMusic():
	$AudioStreamPlayer.play() ;
