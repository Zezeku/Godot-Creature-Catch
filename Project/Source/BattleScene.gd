extends Node2D

onready var player = $Player ;
onready var enemy = $Enemy ;


func _on_BattleStart_PlayBattleMusic():
	$AudioStreamPlayer.play() ;

