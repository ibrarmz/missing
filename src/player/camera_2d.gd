extends Camera2D

func _process(delta):
	var target_y = get_parent().get_node("Player").global_position.y
	global_position.y = lerp(global_position.y, target_y, 0.05)
