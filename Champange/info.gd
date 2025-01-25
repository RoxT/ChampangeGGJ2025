extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_fields_clicked(coords:Vector2i, type:String):
	clear()
	add_text("%s" % coords)
	newline()
	add_text("%s" % type)
