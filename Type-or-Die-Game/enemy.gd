extends Node2D

var speed: float = 200.0
var direction: Vector2 = Vector2(-1, 1)  # Moves diagonally down and to the left
var stopped: bool = false  # Flag to check if the node should stop

func _ready() -> void:
	position.y = -100
	position.x = randf_range(0, get_viewport().size.x)

func _process(delta: float) -> void:
	if not stopped:
		position += direction.normalized() * speed * delta

func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "TargetNode":  # Replace with the actual node name or tag
		stopped = true  # Set flag to stop movement
		# Optionally, you can remove the node or perform other actions here
		# queue_free()  # Uncomment this line if you want to remove the node
