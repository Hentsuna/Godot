extends Node

@export var mob_scene: PackedScene
var Score

func game_over():
	#pass # Replace with function body.
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$Deathsound.play()
	
func  new_game():
	Score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(Score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	$Music.play()


func _on_mob_timer_timeout():
	#Create a new instance of the mob scene
	var mob = mob_scene.instantiate()
	
	#Choose the random location on Path2d(MobPath)
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	#Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position
	
	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	
func _on_score_timer_timeout():
	Score += 1
	$HUD.update_score(Score)


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	
#func _ready():
	
