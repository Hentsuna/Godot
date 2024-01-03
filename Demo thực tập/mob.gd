extends RigidBody2D

func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names() #return array of n names
	$AnimatedSprite2D.play(mob_types[randi() %mob_types.size()]) #randi() % select an integer between 0 and n-1

func _on_visible_on_screen_notifier_2d_screen_exited(): #make the mob delete themselves when they leave the screen
	queue_free()
