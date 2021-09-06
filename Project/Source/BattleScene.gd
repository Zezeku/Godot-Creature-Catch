extends Node2D

onready var player = $Player ;
onready var enemy = $Enemy ;


func _on_BattleStart_PlayBattleMusic():
	$AudioStreamPlayer.play() ;


func set_player(s_player) :
	add_child(s_player) ;
