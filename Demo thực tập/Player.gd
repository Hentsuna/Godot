extends Area2D
signal hit

@export var speed = 400 #How fast the player will move(pixel/second)
var screen_size #Size of the game window
func _ready():
	screen_size = get_viewport_rect().size
	hide() #player will hiden when the game start

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _process(delta):
	var velocity = Vector2.ZERO #The player's movement vector (0,0)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play() # $ = get_node()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size) #clamp() pretent player move out the screen
	
	# flip.h lat theo chieu ngang
	# flip.v lat theo chieu doc
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0 #animation walk left
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0 #animation down


func _on_body_entered(body):
	# pass # Replace with function body.
	hide() #Player disapear after being hit
	hit.emit()
	#  Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled",true) #set.deferred tells Godot to wait to disable the shape until it's safe to do so.
