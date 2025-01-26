extends Node

const Monk := preload("res://monk.tscn")

signal season_ended
@warning_ignore("unused_signal")
signal refresh
@warning_ignore("unused_signal")
var monk_box
@warning_ignore("unused_signal")
signal sold

var money := 0
enum Seasons {SPRING, SUMMER, FALL, WINTER}
var season := 0
var year := 0
var up_keep := 0

var plants := {}

func _ready():
	start()

func start():
	money = 17
	season = 0
	year = 1
	up_keep = 1

func advance_season():
	if season == Seasons.WINTER:
		year += 1
	season = (season + 1) % Seasons.size()
	money -= up_keep
	print("year %s" % year)
	season_ended.emit()

func add_plant(coord):
	plants[coord] = 5
	
