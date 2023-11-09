extends Node3D

@export var right_hand_controller : XRController3D
@export var dialogue : Dialogue3D

var can_interact := false
var is_talking := false

func _ready() -> void:
	dialogue.connect("dialogue_ended", on_dialogue_ended)
	hide_prompt()


func _process(delta: float) -> void:
	if right_hand_controller != null:
		if right_hand_controller.is_button_pressed("ax_button"):
			if can_interact:
				can_interact = false
				print("Inititating talking")
				is_talking = true
				hide_prompt()
				dialogue.start_dialogue()


func on_dialogue_ended():
	print("Dialogue ended. You can talk to me again.")
	is_talking = false
	if not $TriggerArea.get_overlapping_bodies().is_empty():
		show_prompt()
		await get_tree().create_timer(1.0).timeout
		can_interact = true


func _on_trigger_area_body_entered(body: Node3D) -> void:
	if not is_talking:
		can_interact = true
		show_prompt()


func _on_trigger_area_body_exited(body: Node3D) -> void:
	can_interact = false
	hide_prompt()


func show_prompt():
	$Prompt.show()


func hide_prompt():
	$Prompt.hide()
