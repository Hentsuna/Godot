extends Area2D

var speed = 400
var velocity = Vector2(500,0)

func _process(delta: float) -> void:
	position += velocity * delta
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("Da ra")


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	rotate(0.05)
	print("Da vao")
