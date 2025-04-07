extends CharacterBody2D

const SPEED = 100
const FALL_SPEED = 80  # velocidad vertical automática
@onready var ANIMATION = $AnimatedSprite2D

func _ready() -> void:
	ANIMATION.play("default")

func _physics_process(delta):
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * SPEED
	velocity.y = FALL_SPEED  # siempre cayendo hacia abajo
	
	print(self.position)
	move_and_slide()
