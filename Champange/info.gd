extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_field_clicked(coords:Vector2i, type:String):
	clear()
	add_text("%s" % coords)
	newline()
	add_text("%s" % type)


func _on_season_pressed():
	CP.advance_season()
