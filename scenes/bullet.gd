extends RigidBody2D

const SPEED = 1300
var is_active = true

func _physics_process(delta):
	linear_velocity = Vector2(0, -SPEED).rotated(global_rotation)
