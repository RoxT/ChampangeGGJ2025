extends HBoxContainer



# Called when the node enters the scene tree for the first time.
func _ready():
	CP.monk_box = self

func return_monk_to_box():
	add_child(CP.Monk.instantiate())

	
func get_monk()->bool:
	if get_child_count() > 0:
		get_child(0).queue_free()
		return true
	else:
		return false

func _on_child_entered_tree(node):
	if node is TextureRect:
		node.connect("gui_input", _on_monk_gui_input)

func _on_monk_gui_input(_event:InputEvent):
	pass

func _on_child_exiting_tree(node):
	if node is TextureRect:
		node.disconnect("gui_input", _on_monk_gui_input)
