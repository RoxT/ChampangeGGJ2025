extends Panel

var event := ""
var bottles := 0

signal event_over(result)

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	CP.season_ended.connect(_on_season_ended)

func _on_season_ended():
	do_late_season.call_deferred()
	
func do_late_season():
	if CP.money < 0:
		event = "game_over"
		do_event(event)
		return
	if CP.year < 3: return
	event = ""
	match CP.season:
		CP.Seasons.SPRING:
			pass
		CP.Seasons.SUMMER:
			if randf() < 0.5:
				event = "festival"
		CP.Seasons.FALL:
			if randf() < 0.25:
				event = ["pests", "drought", "rain"].pick_random()
		CP.Seasons.WINTER:
			if randf() < 0.20:
				event = "warm"
	if event.is_empty() and (CP.money > 25 or bottles > 3) and randf() < 0.1:
		event = "tax"
	if event.is_empty():
		hide()
	else:
		do_event(event)

func do_event(new_event:String):
	event = new_event
	var title := ""
	var desc := ""
	var b_1 := "Okay"
	var b_2 := ""
	$Panel/Button1.disabled = false
	$Panel/Button2.disabled = false
	
	match event:
		"tax":
			title = "KING'S TAX"
			desc = "The king has demanded 2 bottles of champange or 20 gold coins in tax."
			b_1 = "20 gold coins"
			b_2 = "2 bottles"
			$Panel/Button1.disabled = CP.money < 20
			$Panel/Button2.disabled = bottles < 2
		"drought":
			title = "DROUGHT"
			desc = "A drought this last summer has withered the vines, decreasing the quality of fields this year"
		"warm":
			title = "MILD WINTER"
			desc = "This winter is warmer than normal. It doesn't look like the casks will ferment as well."
		"rain":
			title = "EXCELLENT RAINS"
			desc = "The right amount of rain this summer has improved the quality of the vines this harvest"
		"festival":
			title = "CHAMPANGE FESTIVAL"
			desc = "All bottles sold this season are worth more due to the summer festival."
		"pests":
			title = "PESTS ON CROPS"
			desc = "Fields that weren't tended this summer have lost value for this harvest."
		"game_over":
			title = "GAME OVER"
			desc = "You couldn't pay to feed the monks and the King has repossesed the monastery grounds. Even a vow of poverty couldn't save this vineyard!"
	$Panel/EventLabel.text = title
	$Panel/EventDesc.text = desc
	$Panel/Button1.text = b_1
	$Panel/Button1.visible = not b_1.is_empty()
	$Panel/Button2.text = b_2
	$Panel/Button2.visible = not b_2.is_empty()
	show()
	
func _on_button_1_pressed():
	match event:
		"tax":
			event_over.emit("tax_coin")
		"game_over":
			do_game_over.call_deferred()
		_:
			event_over.emit(event)
	hide()

func do_game_over():
	get_tree().change_scene_to_file("res://TitleScreen.tscn")

func _on_button_2_pressed():
	match event:
		"tax":
			event_over.emit("tax_bottle")
	hide()
