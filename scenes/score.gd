extends Node

var score = 0

func set_score(new_score: int):
	score = new_score
	$CanvasLayer/Label.text = str(score)

func add_score():
	set_score(score + 1)

func _ready():
	set_score(0)
