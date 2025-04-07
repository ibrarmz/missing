extends Area2D

@export var texto: String
@export var sprite_texture: Texture2D
const FALL_SPEED = 80 
var velocity = Vector2(0, -FALL_SPEED)  # Velocidad inicial hacia abajo
signal change_text(new_text)

signal recolectado(texto: String)

func _ready():
	$Sprite2D.texture = sprite_texture

func _process(delta):
	# Aplica la caída
	position += velocity * delta

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		change_text.emit(texto)
		queue_free()
