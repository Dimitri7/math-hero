extends CPUParticles2D

func _ready() -> void:
	# Começa a explosão
	emitting = true
	
	# Espera o tempo de vida das partículas + um pouquinho
	# e depois se deleta.
	await get_tree().create_timer(lifetime).timeout
	queue_free()
