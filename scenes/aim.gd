extends CharacterBody2D

const BOOM = preload("res://scenes/boom.tscn")
const SPEED = 100

func _ready():
	$Sprite.play("default")
	
func _physics_process(delta):
	var player = get_node('/root/main/Player')
	if player and player.visible:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * SPEED
		move_and_slide()
	
	# Посмотрим, какие есть коллизии
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		#var enemy : Enemy = collider as Enemy

		if collider and collider.is_in_group("Bullet"):
			_on_bullet_entered(collider)
		
		if collider and collider.is_in_group("Player"):
			_on_player_entered(collider)

func _create_boom(position):
	var boom =BOOM.instantiate()
	boom.global_position = position
	get_parent().add_child(boom)
	boom.play('default')

func _on_bullet_entered(bullet):
	if bullet.is_active:
		bullet.is_active = false
		bullet.queue_free()
		_create_boom(global_position)
		queue_free()
		get_node('/root/main/Score').add_score()
	
func _on_player_entered(player):
	queue_free()
	_create_boom(player.global_position)
	# player.queue_free()	
	player.visible = false
	# get_tree().paused = true
