extends Node2D

func _on_botao_jogar_pressed() -> void:
	
	AudioManager.iniciar_musica()
	get_tree().change_scene_to_file("res://Cenas/jogo_principal.tscn")


func _on_botao_sair_pressed() -> void:
	get_tree().quit()
