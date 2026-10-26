extends Node

# Referências para os nossos tocadores
@onready var sfx_acerto: AudioStreamPlayer = $SFX_Acerto
@onready var sfx_erro: AudioStreamPlayer = $SFX_Erro
@onready var musica_fundo: AudioStreamPlayer = $MusicaFundo

# Toca o som de acerto
func tocar_acerto() -> void:
	sfx_acerto.play()

# Toca o som de erro
func tocar_erro() -> void:
	sfx_erro.play()

func iniciar_musica() -> void:
	if !musica_fundo.playing:
		musica_fundo.play()

func parar_musica() -> void:
	musica_fundo.stop()
