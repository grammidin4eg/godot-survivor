extends RigidBody2D

class_name Bullet

@export var SPEED = 800
var is_active = true

func playShootSnd():
	$ShootSnd.play()

func _physics_process(delta):
	linear_velocity = Vector2(0, -SPEED).rotated(global_rotation)
