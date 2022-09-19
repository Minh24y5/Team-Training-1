extends Node2D

func update_settings(settings: Dictionary) -> void:
	OS.window_fullscreen = settings.fullscreen
	get_tree().set_screen_stretch(
		SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, settings.resolution
	)
	OS.set_window_size(settings.resolution)
	OS.vsync_enabled = settings.vsync


func _on_UIVideoSettings_apply_button_pressed(settings):
	update_settings(settings)


func _on_Button_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")
