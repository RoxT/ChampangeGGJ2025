extends NinePatchRect

const BatchActions := preload("res://batch_actions.tscn")
@onready var vbox := $ScrollContainer/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	CP.season_ended.connect(_on_season_ended)
	_on_season_ended()

func add_batch_actions(coord:Vector2i):
	var new_batch = BatchActions.instantiate()
	new_batch.quality = CP.plants[coord]
	vbox.add_child(new_batch)
	
func how_many_bottles()->int:
	return vbox.get_child_count()
	
func _on_season_ended():
	var key = "%s_YEAR%s" % [CP.Seasons.keys()[CP.season].to_upper(), CP.year]
	var text = tr(key)
	$HelpLabel.text = text
	if key == text:
		$HelpLabel.text = ""
	else:
		$HelpLabel.text = "Tutorial: \n%s" % text
	
func event_result(result):
	match result:
		"warm":
			for batch in vbox.get_children():
				if batch.sprite.animation == "cask":
					batch.quality -= 4
		"festival":
			for batch in vbox.get_children():
				batch.temp_price = floori(batch.quality * 0.4)
				batch.quality += batch.temp_price
		"tax_bottle":
			
			var children = vbox.get_children()
			var a = children[0]
			for c in children:
				if c.quality < a.quality:
					a = c
			children.erase(a)
			var b = children[0]
			for c in children:
				if c.quality < b.quality:
					b = c
			a.queue_free()
			b.queue_free()
			
			
		
