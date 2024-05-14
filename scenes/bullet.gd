extends RigidBody2D

const SPEED = 1000

func _physics_process(delta):
	linear_velocity = Vector2(0, -SPEED).rotated(global_rotation)
