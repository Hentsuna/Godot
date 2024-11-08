extends Area2D

var speed = 750

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("mod"):
		body.queue_free()
	queue_free()
