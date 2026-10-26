extends CanvasLayer

# --- 1. Referências aos Nós da Interface ---
# (Se der erro nestas linhas, apague o caminho e arraste o nó da cena para cá)
@onready var label_pontuacao: Label = $Pontuacao
@onready var label_combo: Label = $Combo
@onready var barra_de_energia: ProgressBar = $BarraDeEnergia
@onready var label_tabuada: Label = $LabelTabuada

# Referências a nós externos ("Irmãos" na cena principal)
@onready var tela_game_over: CanvasLayer = $"../GameOverUI" 
@onready var gerador_de_notas: Node2D = $"../GeradorDeNotas"


# --- 2. Configuração Inicial (_ready) ---
func _ready() -> void:
	
	# 1. Inicia o jogo (Reseta pontos, energia e nível)
	GameManager.iniciar_jogo()
	
	# 2. Conecta TODOS os sinais do GameManager
	GameManager.pontuacao_atualizada.connect(_on_pontuacao_atualizada)
	GameManager.combo_atualizado.connect(_on_combo_atualizado)
	GameManager.energia_atualizada.connect(_on_energia_atualizada)
	GameManager.game_over.connect(_on_game_over)
	GameManager.tabuada_atualizada.connect(_on_tabuada_atualizada)
	
	# 3. Configurações visuais iniciais
	barra_de_energia.max_value = GameManager.ENERGIA_MAXIMA
	barra_de_energia.value = GameManager.energia
	
	label_pontuacao.text = "Pontos: 0"
	label_combo.visible = false
	tela_game_over.visible = false


# --- 3. Funções de Atualização da UI ---

func _on_pontuacao_atualizada(nova_pontuacao: int) -> void:
	label_pontuacao.text = "Pontos: " + str(nova_pontuacao)


func _on_combo_atualizado(novo_combo: int) -> void:
	if novo_combo > 1:
		label_combo.visible = true
		label_combo.text = "Combo: x" + str(novo_combo)
	else:
		label_combo.visible = false


func _on_energia_atualizada(nova_energia: float) -> void:
	# Anima a barra suavemente (Opcional, mas fica bonito)
	var tween = create_tween()
	tween.tween_property(barra_de_energia, "value", nova_energia, 0.2)


func _on_game_over() -> void:
	# 1. Passa a pontuação final para a tela de Game Over
	tela_game_over.mostrar_resultado_final(GameManager.pontuacao)
	
	# 2. Mostra a tela
	tela_game_over.visible = true
	
	# 3. Para o gerador (impede novas notas)
	gerador_de_notas.get_node("Timer").stop()


# --- 4. A Nova Animação de Nível (O "Pop" Gigante) ---
func _on_tabuada_atualizada(nova_tabuada: int) -> void:
	
	# Define o texto (Usamos quebra de linha \n para ficar bonito centralizado)
	label_tabuada.text = "Múltiplos\nde " + str(nova_tabuada)
	
	# Ajusta o pivô para o centro do texto (para ele crescer do meio)
	# O 'call_deferred' garante que o tamanho do texto atualizou antes de calcular o centro
	label_tabuada.call_deferred("set_pivot_offset", label_tabuada.size / 2)
	
	# Cria a animação
	var tween = create_tween()
	
	# Passo A: Reseta (Pequeno e Brilhante)
	label_tabuada.scale = Vector2(0.1, 0.1)
	label_tabuada.modulate.a = 1.0 # Totalmente visível
	
	# Passo B: Explode (Cresce rápido com efeito elástico)
	tween.tween_property(label_tabuada, "scale", Vector2(1.2, 1.2), 0.4).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	# Passo C: Acalma (Volta ao tamanho normal e fica transparente)
	tween.parallel().tween_property(label_tabuada, "scale", Vector2(1.0, 1.0), 0.2)
	tween.parallel().tween_property(label_tabuada, "modulate:a", 0.15, 0.5)
