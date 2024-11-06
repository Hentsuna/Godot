extends CharacterBody2D

var speed = 400
var target = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		target = get_global_mouse_position()

func _physics_process(delta: float) -> void:
	#Simple move character
	#var direction = Input.get_vector("Left","Right","Up","Down")
	
	#Lấy vị trí chuột bên phải của nhân vật
	#look_at(get_global_mouse_position())
	
	if target:
		velocity = position.direction_to(target) * speed
		if position.distance_to(target) < 10:
			velocity = Vector2.ZERO
	move_and_slide()
	
