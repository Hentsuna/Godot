extends Node2D


func spaw_mob():
	var new_mob = preload("res://mod.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout() -> void:
	spaw_mob()


func _on_player_health_depteted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
