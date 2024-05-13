extends CharacterBody2D


const SPEED = 300.0
var platform_rotation = 0

func runAnimation():
	$Track1.play("run")
	$Track2.play("run")

func stopAnimation():
	$Track1.stop()
	$Track2.stop()


func _physics_process(delta):
	var direction_horizontal = Input.get_axis("ui_left", "ui_right")
	var direction_vertical = Input.get_axis("ui_up", "ui_down")
	
	if direction_horizontal != 0:
		velocity = Vector2.RIGHT * direction_horizontal * SPEED
		rotation_degrees = 90 if direction_horizontal > 0 else -90
		runAnimation()
	elif direction_vertical != 0:
		velocity = Vector2.DOWN * direction_vertical * SPEED
		rotation_degrees = 180 if direction_vertical > 0 else 0
		runAnimation()
	else:
		velocity = Vector2.ZERO
		stopAnimation()
	
	%top.look_at(get_global_mouse_position())
	%top.rotate(90)
	move_and_slide()
