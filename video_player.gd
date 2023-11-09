@tool
extends VideoStreamPlayer

@export var loop := true


func _ready() -> void:
	play()


func _on_finished() -> void:
	if loop:
		play()
