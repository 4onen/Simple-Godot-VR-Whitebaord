extends Spatial

signal button_down
signal button_up

enum {
	BUTTON_UNPRESSED,
	BUTTON_PRESSED
}

var state := BUTTON_UNPRESSED
onready var plunger := $ButtonPlunger
onready var body := $ButtonBody

func _physics_process(_delta):
	var height = plunger.translation.y - body.translation.y
	if state==BUTTON_UNPRESSED:
		if height < 0.020:
			state=BUTTON_PRESSED
			emit_signal("button_down")
	if state==BUTTON_PRESSED:
		if height > 0.030:
			state=BUTTON_UNPRESSED
			emit_signal("button_up")
