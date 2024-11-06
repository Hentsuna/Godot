extends CharacterBody2D

signal health_depteted

var health = 100.0

func _physics_process(delta): #Tốc độ khung hình được đồng bộ hoá với vật lý, delta ko đổi và tính bằng giây
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 600 #Character move 600 pixel one second
	move_and_slide()
	
	if velocity.length() > 0.0: #Nếu có nút dc nhấn thì velocity tăng giá trị lên 600
		get_node("HappyBoo").play_walk_animation() #CharacterBody2D want to use func of HappyBoo node
	else:
		get_node("HappyBoo").play_idle_animation() # getnode()(Chỉ khi là con) == $(Chỉ khi là con) == %(truy cập mọi nơi)
	
	const DAMAGE_RATE = 5.0 #take damage per enemy per second
	var ovelapping_mobs = %HurtBox.get_overlapping_bodies()
	if ovelapping_mobs.size() > 0:
		health -= DAMAGE_RATE * ovelapping_mobs.size() * delta
		%ProgressBar.value = health
	
	if health <= 0.0:
		health_depteted.emit()
