extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_button_pressed():
	CP.start()
	get_tree().change_scene_to_file("res://overworld.tscn")
