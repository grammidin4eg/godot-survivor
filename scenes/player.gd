extends CharacterBody2D


const SPEED = 300.0
const BULLET = preload("res://scenes/bullet.tscn")

var angle_fix = 1.5

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
		angle_fix = 1 if direction_horizontal > 0 else 2
	elif direction_vertical != 0:
		velocity = Vector2.DOWN * direction_vertical * SPEED
		rotation_degrees = 180 if direction_vertical > 0 else 0
		runAnimation()
		angle_fix = 1.5 if direction_vertical < 0 else 2.5
	else:
		velocity = Vector2.ZERO
		stopAnimation()
	
	var pre = %top.global_position - get_global_mouse_position()
	%top.rotation = pre.angle() + angle_fix * PI
	move_and_slide()
	
	if Input.is_action_pressed("fire"):
		var bullet = BULLET.instantiate()
		bullet.global_position = %top/BulletSpawnPoint.global_position
		#bullet.rotation = pre.angle() * PI * 1.5
		bullet.look_at(get_global_mouse_position())
		bullet.add_constant_force(get_global_mouse_position() - bullet.global_position)
		get_parent().add_child(bullet)

