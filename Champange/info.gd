extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	CP.field_clicked.connect(_on_fields_clicked)


func _on_fields_clicked(coords:Vector2i, type:String):
	clear()
	add_text("%s" % coords)
	newline()
	add_text("%s" % type)


func _on_season_pressed():
	CP.advance_season()
