extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Fields.field_clicked.connect(_on_field_clicked)
	$Fields.field_focus.connect(_on_field_focus)
	CP.field_monk_clicked.connect(_on_field_monk_clicked)
	CP.refresh.connect(_on_refresh)

func _on_field_monk_clicked(monk):
	assert(monk is TextureRect)
	$HUD/Panel/MonkBox._on_field_monk_clicked(monk)

func _on_field_focus(coord, type):
	assert(coord is Vector2i)
	assert(type is String)

func _on_field_clicked(coord, type):
	assert(coord is Vector2i)
	assert(type is String)
	if $FieldMonks.monk_focus:
		$HUD/Panel/MonkBox._on_field_monk_clicked($FieldMonks.monk_focus)
	else:
		$HUD/Panel/Info._on_field_clicked(coord, type)
		$FieldMonks.move_monk_to_field($HUD/Panel/MonkBox.get_monk(), $Fields.map_to_local(coord))
		
func _on_refresh():
	$HUD/Panel2/Stats._on_refresh()
