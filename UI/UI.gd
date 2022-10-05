extends CanvasLayer

onready var scoreLabel: Label = $Control/ScoreLabel
onready var notification = $Control/NotificationLabel


func _ready():
	set_score(0)

	Stats.connect("update_score_ui", self, "set_score")
	Stats.connect("on_notification", self, "show_notification")
	Stats.connect("on_notification_close", self, "hide_notification")


func set_score(value):
	scoreLabel.text = String(value)


func show_notification(text):
	notification.show_notification(text)


func hide_notification():
	notification.hide_notification()
