extends CanvasLayer

# --- 1. Referência para o Label da Pontuação ---
# Pega uma referência para o seu Label de pontuação
# Certifique-se que o seu Label se chama "LabelPontuacaoFinal"
# e está dentro do "VBoxContainer"
@onready var label_pontuacao: Label = $VBoxContainer/LabelPontuacaoFinal


# --- 2. Funções dos Botões (Conectadas aos Sinais) ---

# Esta função é chamada quando o BotaoTentarNovamente é clicado
func _on_botao_tentar_novamente_pressed() -> void:
	# Recarrega a cena principal (JogoPrincipal.tscn) do zero
	get_tree().reload_current_scene()


# Esta função é chamada quando o BotaoMenuPrincipal é clicado
func _on_botao_menu_principal_pressed() -> void:
	# Carrega a cena do Menu Principal
	get_tree().change_scene_to_file("res://Cenas/menu_principal.tscn")


# --- 3. Nova Função (Chamada pela Interface) ---

# Esta função será chamada pela InterfaceUI para definir o texto
# ANTES da tela de game over aparecer.
func mostrar_resultado_final(pontuacao: int) -> void:
	# Uma verificação de segurança para garantir que o Label foi encontrado
	if label_pontuacao != null:
		label_pontuacao.text = "Pontuação Final: " + str(pontuacao)
	else:
		# Se você vir esta mensagem no console, o caminho do Label está errado
		print("Erro: Não foi possível encontrar o LabelPontuacaoFinal!")
