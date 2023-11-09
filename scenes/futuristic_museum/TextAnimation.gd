extends MeshInstance3D

@onready var textures : Array[Texture2D] = [
	preload("res://scenes/welcome_text/images/welcome_arab.png"),
	preload("res://scenes/welcome_text/images/welcome_cina.png"),
	preload("res://scenes/welcome_text/images/welcome_filipina.png"),
	preload("res://scenes/welcome_text/images/welcome_hawai.png"),
	preload("res://scenes/welcome_text/images/welcome_india.png"),
	preload("res://scenes/welcome_text/images/welcome_indonesia.png"),
	preload("res://scenes/welcome_text/images/welcome_inggris.png"),
	preload("res://scenes/welcome_text/images/welcome_itali.png"),
	preload("res://scenes/welcome_text/images/welcome_jawa.png"),
	preload("res://scenes/welcome_text/images/welcome_jepang.png"),
	preload("res://scenes/welcome_text/images/welcome_jerman.png"),
	preload("res://scenes/welcome_text/images/welcome_korea.png"),
	preload("res://scenes/welcome_text/images/welcome_portugis.png"),
	preload("res://scenes/welcome_text/images/welcome_prancis.png"),
	preload("res://scenes/welcome_text/images/welcome_rusia.png"),
	preload("res://scenes/welcome_text/images/welcome_spanyol.png"),
	preload("res://scenes/welcome_text/images/welcome_sunda.png"),
	preload("res://scenes/welcome_text/images/welcome_swedia.png"),
	preload("res://scenes/welcome_text/images/welcome_thailand.png"),
	preload("res://scenes/welcome_text/images/welcome_turki.png"),
	preload("res://scenes/welcome_text/images/welcome_ukraina.png"),
	preload("res://scenes/welcome_text/images/welcome_vietnam.png"),
	preload("res://scenes/welcome_text/images/welcome_yunani.png"),
]
@export var switch_time := 5.0
var current_text_index : int = 0
@onready var switch_timer := Timer.new()

func _ready() -> void:
	switch_timer.wait_time = switch_time
	# switch_timer.one_shot = false
	add_child(switch_timer)
	switch_timer.connect("timeout", on_switch_timer_timeout)
	switch_timer.start()
	switch_texture()


func switch_texture() -> void:
	var material: ShaderMaterial = self.get_active_material(0)
	material.set_shader_parameter("Title", textures[current_text_index])


func on_switch_timer_timeout() -> void:
	print("switching texture...")
	current_text_index += 1
	if current_text_index >= textures.size():
		current_text_index = 0
	
	print("Fading in...")
	var fade_in_tween := get_tree().create_tween()
	
	fade_in_tween.tween_property(get_child(1).get_active_material(0), "albedo_color", Color(1,1,1,1), 0.5)
	await fade_in_tween.finished
	
	switch_texture()
	
	print("Fading out...")
	var fade_out_tween := get_tree().create_tween()
	fade_out_tween.tween_property(get_child(1).get_active_material(0), "albedo_color", Color(1,1,1,0), 0.5)
