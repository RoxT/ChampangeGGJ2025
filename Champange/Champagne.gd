extends Node

@warning_ignore("unused_signal")
signal field_clicked(coord, type)
signal refresh()

var money := 10
var actions := 10
enum Seasons {SPRING, SUMMER, FALL, WINTER}
var season := 0

func advance_season():
	season = (season + 1) % Seasons.size()
	actions = 10
	refresh.emit()
