extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_field_focus(coords:Vector2i, type:String):
	var quality = CP.plants.get(coords, -1)
	clear()
	add_text("%s" % type)
	newline()
	if quality > 0:
		add_text("Quality: %s" % quality)
