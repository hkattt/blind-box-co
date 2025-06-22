class_name NextButton extends TextureButton

func _on_button_down() -> void:
	SoundManager.play_sound(SoundManager.Sound.CLICK)
