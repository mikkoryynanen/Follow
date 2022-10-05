extends CanvasLayer

onready var scoreLabel: Label = $Control/ScoreLabel


func _ready():
	set_score(0)

	Stats.connect("update_score_ui", self, "set_score")

func set_score(value):
	scoreLabel.text = String(value)
