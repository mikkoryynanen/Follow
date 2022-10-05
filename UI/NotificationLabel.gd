extends Control

var is_shown = false

onready var tween = $Tween
onready var label = $Label


func hide_notification():
	tween.interpolate_property(
		$Label,
		"rect_position",
		Vector2(5, 5),
		Vector2(5, -50),
		0.5,
		Tween.EASE_IN,
		Tween.EASE_IN_OUT
	)
	tween.start()


func show_notification(text):
	# is_shown = true
	label.text = String(text)

	tween.interpolate_property(
		$Label,
		"rect_position",
		Vector2(5, -50),
		Vector2(5, 5),
		0.25,
		Tween.EASE_IN,
		Tween.EASE_IN_OUT
	)
	tween.start()


