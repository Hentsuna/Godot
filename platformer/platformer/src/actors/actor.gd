extends CharacterBody2D
class_name actor

func _physics_process(delta: float) -> void:
		var velocity = Vector2(300,0)
		move_and_slide(velocity)
