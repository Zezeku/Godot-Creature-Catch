extends AudioStreamPlayer


func _ready():
	get_node("../StateMachine/State").connect("PlayBattleMusic", self, "PlayBattleMusic")

func PlayBattleMusic():
	playing = true ;
