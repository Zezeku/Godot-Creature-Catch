extends Control

var speed ;
const attempts = 3 ;
var attempt = 0 ;
var end = false ;
var rng = RandomNumberGenerator.new() ;

signal done

func _ready():
	set_process(false) ;
	rng.randomize() ;
	var randomNumber = rng.randf_range(8,12);
	speed = randomNumber ;
	

func execute():
	print("yield - catchminigame")
	yield(self, "done")
	print("unyield - catchminigame")

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
	
	
	if $CanvasLayer/OuterCircleBody/OuterCircleShape.scale <= Vector2.ZERO and attempt < 3:
		attempt += 1 ;
		$CanvasLayer/Label.text = "Attempt: " + String(attempt+1)
		if attempt < 3:
			$CanvasLayer/OuterCircleBody/OuterCircleShape.scale = Vector2(12,12) ;
	elif attempt >= 3:
		checkOverlap() ;
	else:
		$CanvasLayer/OuterCircleBody/OuterCircleShape.scale -= Vector2(shrink_speed,shrink_speed) ;

func checkOverlap():
	end = true ;
	set_process(false)
#	$InnerCircleBody.visible = false ;
#	$OuterCircleBody.visible = false ;
	var innerArea = $CanvasLayer/InnerCircleBody/InnerCircelShape.scale
	var outerArea = $CanvasLayer/OuterCircleBody/OuterCircleShape.scale
	var deadZone = $CanvasLayer/DeadZoneBody/CollisionShape2D.scale
	
	if innerArea >= outerArea and deadZone <= outerArea:
		$CanvasLayer/Label.text = "Catch Rate +5%!"
		
	else:
		$CanvasLayer/Label.text = "No extra luck this time."
	
	emit_signal("done") ;

func startOver():
	$CanvasLayer/OuterCircleBody/OuterCircleShape.scale = Vector2(12,12) ;
	attempt = 0 ;
	end = false ;
	$CanvasLayer/Label.text = "Attempt: 1" ;
	rng.randomize() ;
	var randomNumber = rng.randf_range(8,12);
	speed = randomNumber ;
	
