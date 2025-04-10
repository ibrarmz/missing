extends StaticBody2D

@onready var player = $"../../Player"

func _physics_process(delta: float) -> void:
	position.y = player.position.y
