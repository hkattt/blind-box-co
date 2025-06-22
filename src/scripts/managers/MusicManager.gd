extends Node2D

enum Music {
	ELEVATOR,
}

@onready var music_player: AudioStreamPlayer2D = $MusicPlayer

@onready var elevator_music: AudioStream  = preload("res://assets/music/elevator-music.mp3")

@onready var musics: Dictionary = {
	Music.ELEVATOR: elevator_music
}

func play_music(music: Music) -> void:
	if music in musics:
		var audio_stream: AudioStream = musics[music]
		if music_player.stream == audio_stream:
			return
		else:
			music_player.stop()
			music_player.stream = audio_stream
			music_player.play()

func _on_music_player_finished() -> void:
	music_player.play()
