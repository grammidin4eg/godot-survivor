extends Area2D

var is_active: bool

func _ready():
	is_active = true

func _on_bullet_entered(bullet):
	if is_active:
		is_active = false
		$Box.play("boom")
		bullet.queue_free()
