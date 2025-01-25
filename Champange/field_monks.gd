extends Control

var monk_focus

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func move_monk_to_field(monk, pos):
	if monk == null: return
	assert(monk is TextureRect)
	assert(pos is Vector2)
	monk.reparent(self)
	monk.position = pos

func _on_child_entered_tree(node):
	if node is TextureRect:
		node.connect("gui_input", _on_monk_gui_input.bind(node))
		node.connect("mouse_entered", _on_monk_mouse_entered.bind(node))
		node.connect("mouse_exited", _on_monk_mouse_exited.bind(node))

func _on_monk_mouse_entered(monk):
	assert(monk is TextureRect)
	monk_focus = monk

func _on_monk_mouse_exited(monk):
	assert(monk is TextureRect)
	if monk_focus == monk:
		monk_focus = null

func _on_child_exiting_tree(node):
	if node is TextureRect:
		node.disconnect("gui_input", _on_monk_gui_input)
		node.disconnect("mouse_entered", _on_monk_mouse_entered)
		node.disconnect("mouse_exited", _on_monk_mouse_exited)

func _on_monk_gui_input(event:InputEvent, monk):
	assert(monk is TextureRect)
	if event.is_action_pressed("select"):
		CP.field_monk_clicked.emit(monk)
	else:
		monk_focus = monk
