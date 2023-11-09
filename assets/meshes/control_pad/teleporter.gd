extends MarginContainer

@onready var tp_container: VBoxContainer = $TPContainer

var opt_tp_scene := preload("res://scenes/teleport_ui/opt_tp.tscn")

var last_target_transform : Transform3D = Transform3D()

func _ready() -> void:
	print("getting teleport from ready!")
	var tp_pads = get_tree().get_nodes_in_group("teleport_pads") as Array[TeleportPad]
	for tp_pad in tp_pads:
		print("tp pad in ready!")
		var opt_tp : opt_teleport = opt_tp_scene.instantiate()
		tp_container.add_child(opt_tp)
		opt_tp.tp_pos = tp_pad.global_position
		opt_tp.tp_transform = tp_pad.global_transform
		opt_tp.set_title(tp_pad.title)
		opt_tp.connect("confirmed_teleport", on_confirmed_teleport)


func on_confirmed_teleport(pos : Vector3, transf : Transform3D):
	print("moving player to: ")
	print(pos)
	var _player_body : XRToolsPlayerBody = get_parent()._player_body
	print("Player before teleport:")
	print(_player_body.global_position)
	
	var new_transform := transf
	new_transform.basis.y = _player_body.up_player
	new_transform.basis.x = new_transform.basis.y.cross(_player_body.basis.z).normalized()
	new_transform.basis.z = new_transform.basis.x.cross(_player_body.basis.y).normalized()
	
	_player_body.teleport(new_transform)
	_player_body.global_position = pos
	print("Player after teleport:")
	print(_player_body.global_position)
