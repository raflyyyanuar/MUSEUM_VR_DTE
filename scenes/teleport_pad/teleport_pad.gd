@tool
extends Node3D
class_name TeleportPad

## Pad title
@export var title: String: set = _set_title


func _ready() -> void:
	_set_title(title)


func _set_title(value):
	title = value
	if is_inside_tree():
		_update_title()


func _update_title():
	if not title.is_empty():
		var label : Label3D = $Label3D
		label.set_text(title)
	else:
		var label : Label3D = $Label3D
		label.set_text("Pad " + name)
