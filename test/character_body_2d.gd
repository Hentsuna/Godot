extends CharacterBody2D
@onready var screen_size = get_viewport_rect().size

@export var speed = 1200
@export var jump_speed = -1800
@export var gravity = 4000
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25


func _physics_process(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("Left", "Right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
	
	#if position.x > screen_size.x:
	#	position.x = 0
	#if position.x < 0:
	#	position.x = screen_size.x
	#Dung de dich chuyen vi tri khi ra khoi khoang gioi han
	position.x = wrapf(position.x, 0, screen_size.x)
	move_and_slide()
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = jump_speed
		
