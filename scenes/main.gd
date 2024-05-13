extends Node2D


func _on_screen_body_exited(body):
	body.queue_free()
