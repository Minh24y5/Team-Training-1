extends Panel
signal apply_button_pressed(settings)
# We store the selected settings in a dictionary
var _settings := {resolution = Vector2(640, 480), fullscreen = false, vsync = false}


# Emit the `apply_button_pressed` signal, when user presses the button.
func _on_ApplyButton_pressed() -> void:
	emit_signal("apply_button_pressed", _settings)

func _on_UIResolutionSelector_resolution_changed(new_resolution):
	_settings.resolution = new_resolution

func _on_UIFullScreenCheckbox_toggled(is_button_pressed):
	_settings.fullscreen = is_button_pressed

func _on_UIVsyncCheckbox_toggled(is_button_pressed):
	_settings.vsync = is_button_pressed
