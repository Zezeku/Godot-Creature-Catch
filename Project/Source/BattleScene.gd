extends Node2D

onready var player = $Player ;

# get data for battleScene 
# enemies, background, weather, player party data

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_parent().change_to_world_state() ;
	
