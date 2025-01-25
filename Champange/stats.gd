extends RichTextLabel


const Icons = preload("res://seasons.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_refresh()

func _on_refresh():
	clear()
	add_image(Icons, 0, 0, Color.WHITE, INLINE_ALIGNMENT_CENTER, Rect2(CP.season*32, 0, 32, 32))
	add_text(CP.Seasons.keys()[CP.season])
	newline()
	add_text("$%s" % CP.money)
	newline()
	add_text("actions left: %s" % CP.actions)
	
	
