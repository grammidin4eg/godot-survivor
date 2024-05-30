extends CharacterBody2D


const SPEED = 300.0
const BULLET_LIST = [
	preload("res://scenes/bullet.tscn"), 
	preload("res://scenes/laser_bullet.tscn"),
	preload("res://scenes/big_bullet.tscn"),
	]
var cur_bullet: int = 0
@onready var bulletUi: Sprite2D = get_node("/root/main/CanvasLayer/BulletUI")
var bullet_timer : Timer = Timer.new()

func runAnimation():
	$Track1.play("run")
	$Track2.play("run")

func stopAnimation():
	$Track1.stop()
	$Track2.stop()

func _ready():
	bullet_timer.wait_time = 0.5
	bullet_timer.one_shot = true
	add_child(bullet_timer)

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
	%top.rotate(PI / 2)
	move_and_slide()
	
	if Input.is_action_pressed("fire") and bullet_timer.is_stopped():
		bullet_timer.start()
		var bullet: Bullet = BULLET_LIST[cur_bullet].instantiate()
		bullet.global_position = %top/BulletSpawnPoint.global_position
		bullet.global_rotation = %top.global_rotation
		get_parent().add_child(bullet)
		bullet.playShootSnd()
	
	if Input.is_action_just_pressed("next_bullet") and cur_bullet < (BULLET_LIST.size() - 1):
		cur_bullet += 1
		bulletUi.frame = cur_bullet
	if Input.is_action_just_pressed("prev_bullet") and cur_bullet > 0:
		cur_bullet -= 1
		bulletUi.frame = cur_bullet

