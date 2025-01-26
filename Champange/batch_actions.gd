extends Panel

@onready var sprite := $AnimatedSprite2D
@onready var button_1 := $Button1
@onready var button_2 := $Button2
var monk

var quality := 5
var has_riddled := false
var temp_price := 0
var years := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	CP.season_ended.connect(_next_season)
	CP.refresh.connect(refresh)
	setup("cask")

func _next_season():
	if CP.season == CP.Seasons.SPRING and sprite.animation == "bottled":
		quality += 2
		years += 1
	if monk is TextureRect:
		var button:Button = monk.get_parent()
		var action = button.text
		button.button_pressed = false
		_return_monk()
		match action:
			"Bottle":
				sprite.animation = "bottled"
			"Riddle":
				quality += 2
				has_riddled = true
			"Sell":
				CP.money += quality
				queue_free()
	quality -= temp_price
	temp_price = 0
	setup(sprite.animation)

func refresh():
	if quality < 1: quality = 1
	$YearsLabel.text = "%s\nyrs" % years
	$QualityLabel.text = "%s" % quality
	

func setup(state:String):
	match state:
		"cask":
			sprite.play("cask")
			if CP.season == CP.Seasons.WINTER:
				button_1.text = "Fermenting..."
				button_1.disabled = true
			else:
				button_1.text = "Bottle"
				button_1.disabled = false
			button_2.hide()
		"bottled":
			sprite.play("bottled")
			if CP.year < 3:
				button_2.hide()
			else:
				button_2.show()
			button_2.text = "Sell"
			if has_riddled:
				button_1.disabled = true
				button_1.text = "Riddled"
			else:
				button_1.disabled = false
				button_1.text = "Riddle"
	refresh()


func move_monk_to(button:Button):
	if monk is TextureRect:
		monk.reparent(button)
	else:
		if CP.monk_box.get_monk():
			monk = CP.Monk.instantiate()
			button.add_child(monk)
			if button == button_2:
				$AnimatedSprite2D/LabelSprite.show()
		else:
			button.set_pressed_no_signal(false)
	
	if monk is TextureRect:
		monk.position = Vector2(-21, -1)
			

func _on_button_1_toggled(toggled_on):
	if toggled_on:
		move_monk_to(button_1)
	else:
		_return_monk()
		
func _return_monk():
	if monk:
		CP.monk_box.return_monk_to_box()
		monk.queue_free()
		monk = null

func _on_button_2_toggled(toggled_on):
	$AnimatedSprite2D/LabelSprite.hide()
	if toggled_on:
		move_monk_to(button_2)
	else:
		_return_monk()
