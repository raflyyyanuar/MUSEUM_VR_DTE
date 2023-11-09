extends Node3D
class_name PauseMenu

@export var pause_button : String = "by_button"
@export var pause_touch  : String = "by_touch"

# Controller node
@onready var controller := XRHelpers.get_xr_controller(self)


func _physics_process(delta: float) -> void:
	if controller and controller.get_is_active():
		if controller.is_button_pressed(pause_button):
			print("Opened pause menu")
