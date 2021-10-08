extends ParallaxBackground



func _ready():
# warning-ignore:return_value_discarded
	get_node("../../StateMachine/State").connect("setBackground", self, "setBackground") ;

func setBackground():
	$BackgroundImage.texture = get_node("../../../").battle_background.stageBackground ;
	$CanvasModulate.color = get_node("../../../").battle_background.canvasModulate ;
