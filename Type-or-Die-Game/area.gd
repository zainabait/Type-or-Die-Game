extends Node2D

@export var asteroid_scene: PackedScene
@export var spawn_interval: float = 2.0
@export var words: Array = ["cat", "dog", "bird", "fish", "tree", "house"]

var input_word: String = ""

func _ready() -> void:
	if $Timer:
		$Timer.wait_time = spawn_interval
		$Timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
		$Timer.start()

	if $Control and $Control.get_node("Panel/Label"):
		$Control.get_node("Panel/Label").text = input_word

func _process(delta: float) -> void:
	if $Control and $Control.get_node("Panel/Label"):
		$Control.get_node("Panel/Label").text = input_word

	_check_input_word()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var keycode = event.keycode
		var key = keycode_to_string(keycode)
		if key.length() == 1:
			input_word += key

func _on_Timer_timeout() -> void:
	_spawn_asteroid()

func _spawn_asteroid() -> void:
	if asteroid_scene:
		var asteroid = asteroid_scene.instantiate()
		var random_index = randi() % words.size()
		var word = words[random_index]
		
		if asteroid and asteroid.has_node("Label"):
			var label = asteroid.get_node("Label") as Label
			label.text = word

			var spawn_x = randi() % int(get_viewport().size.x)
			asteroid.position = Vector2(spawn_x, -50)
			add_child(asteroid)
			asteroid.add_to_group("asteroids")

			print("Asteroid spawned at: ", asteroid.position, " with word: ", word)
		else:
			print("Label node not found in asteroid scene")

func _check_input_word() -> void:
	for asteroid in get_tree().get_nodes_in_group("asteroids"):
		if asteroid and asteroid.has_node("Label"):
			var label = asteroid.get_node("Label") as Label
			if label.text == input_word:
				print("Word matched: ", input_word)
				asteroid.queue_free()
				input_word = ""
				return

func _on_Area2D_body_entered(body: Node) -> void:
	if body is RigidBody2D:
		print("Game Over")
		get_tree().reload_current_scene()

func keycode_to_string(keycode: int) -> String:
	var key_event = InputEventKey.new()
	key_event.physical_keycode = keycode
	return key_event.as_text()
