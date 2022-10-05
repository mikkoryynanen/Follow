extends Node2D

const CORRECT_SEQUENCE_BASE_SCORE = 10
const GUESS_CORRECT_NOTIFICATION_TEXT = "CORRECT!"

var current_score = 0

signal update_score(value)
signal update_score_ui(value)
signal on_notification(text)
signal on_notification_close(text)


func _ready():
	connect("update_score", self, "set_score")


func reset():
	current_score = 0

func set_score(numbers_count):
	current_score += numbers_count * CORRECT_SEQUENCE_BASE_SCORE
	emit_signal("update_score_ui", current_score)

