extends Button


export (String) var scene_to_load ;
export (String) var sceneName ;
export (String) var button_label ;

func _ready():
	text = button_label ;
