class_name Dialogue3D
extends Node3D

signal dialogue_ended

@export_multiline var dialogues : Array[String]
@export var right_hand_controller : XRController3D
@export var text_speed := 0.1
@onready var label_3d: Label3D = $Label3D

## Button to trigger next dialogue
@export var dialogue_button_action : String = "ax_button"

var index := 0
var is_showing_dialogue := false
var current_dialogue := ""
var current_length := 0

var is_button_valid := true
var is_valid := false

func _ready() -> void:
	hide()
	$TextSpeedTimer.wait_time = text_speed
	
	# not all dialogue 3d should start at _ready
	# start_dialogue()


func _process(delta: float) -> void:
	if not is_valid:
		return
	
	if right_hand_controller != null:
		if right_hand_controller.is_button_pressed(dialogue_button_action):
			if is_button_valid:
				is_button_valid = false
				if not is_showing_dialogue:
					show_next_dialogue()
				else:
					$TextSpeedTimer.wait_time = text_speed / 100.0
		else:
			is_button_valid = true


func start_dialogue():
	index = 0
	show()
	show_next_dialogue()


func show_next_dialogue():
	if index >= dialogues.size():
		emit_signal("dialogue_ended")
		is_valid = false
		despawn()
	else:
		$TextSpeedTimer.wait_time = text_speed
		is_showing_dialogue = true
		label_3d.text = ""
		current_length = 0
		current_dialogue = dialogues[index]
		index += 1
		$TextSpeedTimer.start()


func despawn() -> void:
	var despawn_tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	despawn_tween.tween_property(self, "scale", Vector3(1.0, 1.1, 1.0), 0.1)
	despawn_tween.tween_property(self, "scale", Vector3(1.0, 0.0, 1.0), 0.5)
	await despawn_tween.finished
	restart()


func restart():
	hide()
	scale = Vector3.ONE
	index = 0


func _on_text_speed_timer_timeout() -> void:
	if label_3d.text != current_dialogue:
		label_3d.text += current_dialogue[current_length]
		current_length += 1
		$TextSpeedTimer.start()
	else:
		is_showing_dialogue = false


func _on_visibility_changed() -> void:
	is_valid = visible
