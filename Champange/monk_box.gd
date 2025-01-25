extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_field_monk_clicked(monk):
	assert(monk is TextureRect)
	if monk is TextureRect:
		monk.reparent(self)

	
func get_monk():
	if get_child_count() > 0:
		return get_child(0)
	else:
		return null

func _on_child_entered_tree(node):
	if node is TextureRect:
		node.connect("gui_input", _on_monk_gui_input)

func _on_monk_gui_input(_event:InputEvent):
	pass

func _on_child_exiting_tree(node):
	if node is TextureRect:
		node.disconnect("gui_input", _on_monk_gui_input)
