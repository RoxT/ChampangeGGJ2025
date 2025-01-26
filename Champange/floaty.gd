extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(0, -32), 0.7)
	tween.tween_callback(_on_tween_finished)
	
	
func _on_tween_finished():
	queue_free()
