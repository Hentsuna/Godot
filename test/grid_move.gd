extends Area2D
@onready var ray = $RayCast2D
var tile_size = 64
var inputs = {"Right": Vector2.RIGHT,"Left": Vector2.LEFT,"Up": Vector2.UP,"Down": Vector2.DOWN}
var animation_speed = 3
var moving = false

func _ready():
	position = position.snapped(Vector2.ZERO * tile_size) #Làm cho tâm pos trở thành góc của 1 ô
	position += Vector2.ONE * tile_size/2 #Làm cho pos tiến thêm 32 và tâm pos thành tâm ô
	
func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		var tween = create_tween()
		tween.tween_property(self, "position", position + inputs[dir] * tile_size, 1.0 / animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false
