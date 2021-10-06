extends AudioStreamPlayer


func _ready():
# warning-ignore:return_value_discarded
	get_node("../StateMachine/State").connect("PlayBattleMusic", self, "PlayBattleMusic")

func PlayBattleMusic():
	playing = true ;
