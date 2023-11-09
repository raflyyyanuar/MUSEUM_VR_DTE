extends HBoxContainer
class_name opt_teleport

signal confirmed_teleport

var tp_pos : Vector3
var tp_transform : Transform3D

func _on_button_pressed() -> void:
	print("going to " + $Name.text)
	emit_signal("confirmed_teleport", tp_pos, tp_transform)


func set_title(title : String):
	$Name.set_text(title)
