extends Panel

var event := ""

signal event_over(result)

# Called when the node enters the scene tree for the first time.
func _ready():
	CP.season_ended.connect(_on_season_ended)

func _on_season_ended():
	do_late_season.call_deferred()
	
func do_late_season():
	var event = ""
	match CP.season:
		CP.Seasons.SPRING:
			pass
		CP.Seasons.SUMMER:
			if randf() < 0.5:
				event = ["drought", "festival", "rains", "pests"].pick_random()
		CP.Seasons.FALL:
			pass
		CP.Seasons.WINTER:
			if randf() < 0.20:
				event = "warm"
	if event.is_empty() and randf() < 0.9:
		event = "tax"
	if not event.is_empty():
		do_event(event)

func do_event(new_event:String):
	event = new_event
	var title := ""
	var desc := ""
	var b_1 := "Okay"
	var b_2 := ""
	
	match event:
		"tax":
			title = "KING'S TAX"
			desc = "The king has demanded 2 bottles of champange or 20 gold coins in tax."
			b_1 = "20 gold coins"
			b_2 = "2 bottles"
		"drought":
			title = "DROUGHT"
			desc = "A drought this summer has withered the vines, decreasing the quality of fields this year"
		"warm":
			title = "MILD WINTER"
			desc = "This winter is warmer than normal. It doesn't look like the casks will ferment as well."
		"rain":
			title = "DROUGHT"
			desc = "A drought this summer has withered the vines, decreasing the quality of fields this year"
		"festival":
			pass
		"pests":
			pass
	$Panel/EventLabel.text = title
	$Panel/EventDesc.text = desc
	$Panel/Button1.text = b_1
	$Panel/Button1.visible = not b_1.is_empty()
	$Panel/Button2.text = b_2
	$Panel/Button2.visible = not b_2.is_empty()
	
func _on_button_1_pressed():
	match event:
		"tax":
			CP.money -= 10
			event_over.emit("tax_coin")
		"drought":
			pass
		"warm":
			pass
		"rain":
			pass
		"festival":
			pass
		"pests":
			pass
	event_over.emit(event)
	$Panel.hide()


func _on_button_2_pressed():
	match event:
		"tax":
			CP.money -= 10
			event_over.emit("tax_bottle")
	$Panel.hide()
