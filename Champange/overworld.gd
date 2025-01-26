extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Fields.field_clicked.connect(_on_field_clicked)
	$Fields.field_focus.connect(_on_field_focus)
	CP.refresh.connect(_on_refresh)
	CP.season_ended.connect(_on_season_ended)

func _on_field_focus(coord, type):
	assert(coord is Vector2i)
	assert(type is String)
	$HUD/RightP/Info._on_field_focus(coord, type)

func _on_field_clicked(coord, type):
	assert(coord is Vector2i)
	assert(type is String)
	if $FieldMonkLayer.remove_monk_at(coord):
		$HUD/LeftP/MonkBox.return_monk_to_box()
	else:
		match CP.season:
			CP.Seasons.SPRING:
				match type:
					"planted", "empty":
						if $HUD/LeftP/MonkBox.get_monk():
							$FieldMonkLayer.place_monk_at(coord, type)
			CP.Seasons.SUMMER:
				match type:
					"planted":
						if $HUD/LeftP/MonkBox.get_monk():
							$FieldMonkLayer.place_monk_at(coord, type)
			CP.Seasons.FALL:
				match type:
					"planted":
						if $HUD/LeftP/MonkBox.get_monk():
							$FieldMonkLayer.place_monk_at(coord, type)
					
	

func _on_refresh():
	$HUD/LeftP._on_refresh.call_deferred()
	
func _on_season_ended():
	var working_monks = $FieldMonkLayer.get_used_cells()
	for monk_coord in working_monks:
		$Fields.do_work_at(monk_coord)
		if CP.season == CP.Seasons.WINTER:
			$HUD/RightP.add_batch_actions(monk_coord)
		$HUD/LeftP/MonkBox.return_monk_to_box()
	$FieldMonkLayer.clear()
	if CP.season == CP.Seasons.SPRING:
		for plant_coord in CP.plants.keys():
			CP.plants[plant_coord] = 5
	if $HUD/LeftP.get_builder():
		$Fields.new_house()
		CP.money -= 15
	CP.refresh.emit()


func _unhandled_input(event):
	if event.is_action_pressed("esc"):
		get_tree().quit()


func _on_modal_event_over(result):
	match result:
		"tax_coin":
			pass
		"tax_bottle":
			pass
