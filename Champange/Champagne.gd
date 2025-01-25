extends Node

signal season_ended
@warning_ignore("unused_signal")
signal refresh

var money := 10
enum Seasons {SPRING, SUMMER, FALL, WINTER}
var season := 0

func advance_season():
	season = (season + 1) % Seasons.size()
	money -= 1
	season_ended.emit()
