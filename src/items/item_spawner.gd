extends Node2D

@export var falling_item_scene: PackedScene
@export var json_path : String = "res://src/items/items.json"
@export var json_data : Dictionary
@export var zona := "zona1"
@onready var player = $"../Player"
@onready var message = $"../Message"

var spawn_timer := 0.0
var spawn_interval := 6.5
var current_index := 0
var items := []

func _ready():
	var file = FileAccess.open(json_path, FileAccess.READ)
	if file:
		var raw_text = file.get_as_text()
		var json = JSON.parse_string(raw_text)
		if typeof(json) == TYPE_DICTIONARY:
			json_data = json
			items = json_data.get(zona, [])
		else:
			print("Error al parsear el JSON.")
	else:
		print("No se pudo abrir el archivo JSON.")

func _process(delta):
	spawn_timer += delta
	
	if current_index >= items.size():
		if spawn_timer >= spawn_interval:
			spawn_timer = 0
			LevelTransition.transition()
			await  LevelTransition.on_transition_finished
			game_over()
		return  # Ya no hay más ítems, no hacer nada

	if spawn_timer >= spawn_interval:
		spawn_timer = 0
		spawn_next_item()

func spawn_next_item():
	if current_index >= items.size():
		return  # Prevención doble, por si acaso

	var item_data = items[current_index]
	var item_instance = falling_item_scene.instantiate()

	var x_pos = randi_range(-48, 51)
	item_instance.position = Vector2(x_pos, player.position.y + 200)

	item_instance.texto = item_data["text"]
	item_instance.sprite_texture = load(item_data["sprite"])
	
	# Conectar la señal para pasar el texto a la UI
	item_instance.change_text.connect(message.set_texto)

	add_child(item_instance)
	current_index += 1  # Avanza al siguiente ítem

func game_over():
	get_tree().change_scene_to_file("res://src/altar/altar.tscn")
