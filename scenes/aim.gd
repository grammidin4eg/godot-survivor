extends Area2D

const BOOM = preload("res://scenes/boom.tscn")

func _on_bullet_entered(bullet):
	bullet.queue_free()
	var boom =BOOM.instantiate()
	boom.global_position = global_position
	get_parent().add_child(boom)
	boom.play('default')
	queue_free()
