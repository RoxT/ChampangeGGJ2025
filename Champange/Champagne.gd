extends Node

const Monk := preload("res://monk.tscn")

signal season_ended
@warning_ignore("unused_signal")
signal refresh
@warning_ignore("unused_signal")
var monk_box

var money := 17
enum Seasons {SPRING, SUMMER, FALL, WINTER}
var season := 0
var year := 1

var plants := {}

func advance_season():
	if season == Seasons.WINTER:
		year += 1
	season = (season + 1) % Seasons.size()
	money -= 1
	print("year %s" % year)
	season_ended.emit()

func add_plant(coord):
	plants[coord] = 5
	
