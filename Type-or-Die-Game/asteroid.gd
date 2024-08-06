extends RigidBody2D

@export var speed: float = 10.0  # Speed at which the asteroid moves downwards
@export var x_variation: float = 50.0  # Horizontal movement range
@export var words: Array = ["cat", "dog", "bird", "fish", "tree", "house"]  # List of words

var direction: Vector2

func _ready() -> void:
	# Set the asteroid to start from a random position on the right edge
	var screen_width = get_viewport().size.x
	var start_x = randi() % int(screen_width)
	var start_y = -50

	# Set initial position
	position = Vector2(start_x, start_y)
	
	# Set initial velocity with horizontal movement towards the left
	direction = Vector2(-speed - randf_range(0, x_variation), speed)
	linear_velocity = direction

	# Set the word in the label
	var label = $Label
	if label:
		label.text = words[randi() % words.size()]

func _physics_process(delta: float) -> void:
	# Ensure the asteroid keeps moving with the initial direction
	linear_velocity = direction
