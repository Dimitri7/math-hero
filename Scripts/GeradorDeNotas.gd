extends Node2D

# 1. Carregamos o "molde" da nossa cena Nota.
const CENA_DA_NOTA = preload("res://Cenas/Nota.tscn")

# 2. Lista com as posições X das 4 pistas.
var posicoes_x_das_pistas = [426, 526, 626, 726]

# 3. Referência ao Timer.
@onready var timer = $Timer 

# 4. Intervalo de tempo aleatório.
@export var tempo_minimo: float = 0.5
@export var tempo_maximo: float = 1.3

# ####################################################################
# NOVO: Constantes de Velocidade
# A velocidade que o jogo começa (Nível 2)
const VELOCIDADE_BASE: float = 200.0 
# Quantos pixels/s mais rápido a cada nível
const INCREMENTO_VELOCIDADE_POR_NIVEL: float = 25.0 
# ####################################################################


# _ready() é chamada no início do jogo.
func _ready() -> void:
	iniciar_proximo_timer()


# iniciar_proximo_timer()
func iniciar_proximo_timer() -> void:
	var tempo_aleatorio = randf_range(tempo_minimo, tempo_maximo)
	timer.wait_time = tempo_aleatorio
	timer.start()


# Esta é a função que o Timer chama...
func _on_timer_timeout() -> void:
	
	# Criamos a nota
	var nova_nota = CENA_DA_NOTA.instantiate()

	# ####################################################################
	# NOVO: Lógica de Velocidade
	
	# 1. Pega o nível atual (que começa em 2)
	var nivel_atual = GameManager.tabuada_atual
	
	# 2. Calcula a nova velocidade
	# Ex: Nível 2 (Início): 200 + (25 * (2-2)) = 200
	#     Nível 3: 200 + (25 * (3-2)) = 225
	#     Nível 4: 200 + (25 * (4-2)) = 250
	var nova_velocidade = VELOCIDADE_BASE + (INCREMENTO_VELOCIDADE_POR_NIVEL * (nivel_atual - 2))
	
	# 3. Define a velocidade na própria nota
	nova_nota.velocidade = nova_velocidade
	
	# ####################################################################


	# --- LÓGICA DA MATEMÁTICA (Fica igual) ---
	var vai_ser_correta = randf() < 0.7 
	var numero_da_nota: int

	if vai_ser_correta:
		var multiplicador = randi_range(1, 10)
		numero_da_nota = GameManager.tabuada_atual * multiplicador
	else:
		numero_da_nota = randi_range(1, 70)
		if numero_da_nota % GameManager.tabuada_atual == 0:
			numero_da_nota += 1

	nova_nota.configurar(numero_da_nota, vai_ser_correta)
	# --- FIM DA LÓGICA DA MATEMÁTICA ---


	# Posiciona a nota (Fica igual)
	var indice_aleatorio = randi_range(0, 3)
	var x_aleatorio = posicoes_x_das_pistas[indice_aleatorio]
	
	nova_nota.position.x = x_aleatorio
	nova_nota.position.y = self.position.y
	
	get_parent().add_child(nova_nota)
