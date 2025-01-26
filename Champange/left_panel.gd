extends Panel


func _ready():
	_on_refresh()

func _on_refresh():
	$SeasonIcon.frame = CP.season
	$SeasonLabel.text = "%s\nYear %s" % [CP.Seasons.keys()[CP.season], CP.year]
	$CoinsLabel.text = "%s coins" % CP.money


func _on_season_pressed():
	print("season pressed %s" % CP.year)
	CP.advance_season()
