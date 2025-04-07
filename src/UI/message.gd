extends Node2D

const FALL_SPEED = 80
var velocity = Vector2(0, FALL_SPEED)  # Velocidad inicial hacia abajo
@onready var text_label  = $Label

func  _ready() -> void:
	self.position.x = -60

func _process(delta: float) -> void:
	self.position.y += velocity.y * delta

func set_texto(new_text: String):
	text_label.text = new_text
