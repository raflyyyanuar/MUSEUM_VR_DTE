@tool
extends Node3D


@onready var info_panel : MeshInstance3D = $InformationPanel/Info
@export var info_texture : Texture2D = preload("res://textures/papaninfo.png"): set = _set_info


func _set_info(value) -> void:
	print(info_panel.get_active_material(0))
	info_texture = value
	if is_inside_tree():
		_update_info()


func _update_info():
	if info_texture:
		info_panel.get_active_material(0).set_texture(0, info_texture)

