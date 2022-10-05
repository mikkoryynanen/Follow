extends CanvasLayer

onready var scoreLabel: Label = $Control/ScoreLabel

func _ready():
	scoreLabel.text = "0"

