extends NinePatchRect

const BatchActions := preload("res://batch_actions.tscn")
@onready var vbox := $VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	CP.season_ended.connect(_on_season_ended)
	_on_season_ended()

func add_batch_actions(coord:Vector2i):
	var new_batch = BatchActions.instantiate()
	vbox.add_child(new_batch)
	new_batch.quality = CP.plants[coord]
	
func _on_season_ended():
	var key = "%s_YEAR%s" % [CP.Seasons.keys()[CP.season].to_upper(), CP.year]
	var text = tr(key)
	$HelpLabel.text = text
	if key == text:
		$HelpLabel.text = ""
	else:
		$HelpLabel.text = "Tutorial: \n%s" % text
	
