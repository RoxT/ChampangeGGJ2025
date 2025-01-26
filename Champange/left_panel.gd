extends Panel

var builder

func _ready():
	_on_refresh()

func _on_refresh():
	$SeasonIcon.frame = CP.season
	$SeasonLabel.text = "%s\nYear %s" % [CP.Seasons.keys()[CP.season], CP.year]
	$CoinsLabel.text = "%s coins" % CP.money
	$BuildPanel/BuildBtn.disabled = CP.money < 15
	$BuildPanel.visible = CP.year >= 3 and CP.season != CP.Seasons.WINTER
	$UpkeepLabel.text = "Upkeep: %s coins" % CP.up_keep
	$UpkeepLabel.theme_type_variation = "upkeep_crisis" if CP.up_keep > CP.money else ""

func get_builder()->bool:
	if builder:
		CP.monk_box.return_monk_to_box()
		builder.queue_free()
		builder = null
		return true
	else:
		return false

func _on_season_pressed():
	if $SeasonTimer.is_stopped():
		print("season pressed %s" % CP.season)
		CP.advance_season()
		$SeasonTimer.start()

func _on_monk_box_changed_monk(all_busy):
	if all_busy:
		$Season.theme_type_variation = "full"
	else:
		$Season.theme_type_variation = ""

func _on_build_btn_toggled(toggled_on):
	if toggled_on:
		if builder is TextureRect:
			builder.reparent($BuildPanel/BuildBtn)
		else:
			if CP.monk_box.get_monk():
				builder = CP.Monk.instantiate()
				$BuildPanel/BuildBtn.add_child(builder)
			else:
				$BuildPanel/BuildBtn.set_pressed_no_signal(false)
		
		if builder is TextureRect:
			builder.position = Vector2(-21, -1)
	elif builder:
			CP.monk_box.return_monk_to_box()
			builder.queue_free()
			builder = null
