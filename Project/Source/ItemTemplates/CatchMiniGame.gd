extends Control

const speed_max = 4.5 ;
const speed_min = 2 ;
var speed ;
const attempts = 3 ;
var attempt = 0 ;
var end = false ;
var rng = RandomNumberGenerator.new() ;
var isSuccess = false ;

signal done

func _ready():
	set_process(false) ;
	rng.randomize() ;
	var randomNumber = rng.randf_range(speed_min,speed_max);
	speed = randomNumber ;
	

func execute():
	print("yield - catchminigame")
	yield(self, "done") ;
	print("unyield - catchminigame")
	return isSuccess ;

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and is_processing() and !end:
		checkOverlap();
	elif event.is_action_pressed("ui_accept") and !end:
		set_process(true) ;
	elif event.is_action_pressed("ui_accept") and end:
		startOver() ;
	elif event.is_action_pressed("ui_cancel"):
		get_parent().remove_child(self) ;

func _process(delta):
	shrinkOuterCircle(delta) ;

func shrinkOuterCircle(delta):
	var shrink_speed = speed * delta ;
	
	
	if $CanvasLayer/OuterCircleBody.scale <= Vector2.ZERO and attempt < 3:
		attempt += 1 ;
		if attempt < 3:
			$CanvasLayer/OuterCircleBody.scale = Vector2(2.5,2.5) ;
	elif attempt >= 3:
		checkOverlap() ;
	else:
		$CanvasLayer/OuterCircleBody.scale -= Vector2(shrink_speed,shrink_speed) ;

func checkOverlap():
	end = true ;
	set_process(false)
#	$InnerCircleBody.visible = false ;
#	$OuterCircleBody.visible = false ;
	var innerArea = $CanvasLayer/InnerCircleBody.scale
	var outerArea = $CanvasLayer/OuterCircleBody.scale
	var deadZone = $CanvasLayer/DeadZoneBody.scale
	
	if innerArea >= outerArea and deadZone <= outerArea:
		isSuccess = true ;
	
	emit_signal("done") ;

func startOver():
	$CanvasLayer/OuterCircleBody.scale = Vector2(2,2) ;
	attempt = 0 ;
	end = false ;
	rng.randomize() ;
	var randomNumber = rng.randf_range(speed_min,speed_max);
	speed = randomNumber ;
	
