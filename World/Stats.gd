extends Node2D

const CORRECT_SEQUENCE_BASE_SCORE = 10

var current_score = 0

signal update_score(value)
signal update_score_ui(value)


func _ready():
	connect("update_score", self, "set_score")

func set_score(numbers_count):
	current_score += numbers_count * CORRECT_SEQUENCE_BASE_SCORE
	emit_signal("update_score_ui", current_score)

