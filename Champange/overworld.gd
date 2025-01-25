extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Fields.clicked.connect($HUD/Panel/Info._on_fields_clicked)
