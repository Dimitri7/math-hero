extends VideoStreamPlayer

func _ready() -> void:
	# Garante que o volume esteja mudo e comece a tocar
	volume_db = -80
	play()

func _on_finished() -> void:
	# Quando acabar, toca de novo (Loop infinito)
	play()
