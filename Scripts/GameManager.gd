extends Node

# --- SINAIS ---
signal pontuacao_atualizada(nova_pontuacao)
signal combo_atualizado(novo_combo)
signal energia_atualizada(nova_energia)
signal game_over
signal tabuada_atualizada(nova_tabuada)

# --- Variáveis do Jogo ---
var pontuacao: int = 0
var combo: int = 0
var pontuacao_por_acerto: int = 100

# --- Variáveis de Energia ---
var energia: float = 100.0
const ENERGIA_MAXIMA: float = 100.0
const PERDA_POR_ERRO: float = 10.0 # Perde 10% por erro

# ####################################################################
# ATUALIZADO: 5 acertos para 1 erro (10.0 / 5 = 2.0)
const GANHO_POR_ACERTO: float = 2.0 
# ####################################################################


# --- Variáveis de Nível ---
var tabuada_atual: int = 2
var pontos_para_proximo_nivel: int = 0
const META_PONTOS_BASE: int = 25000 
const PONTOS_PERDIDOS_POR_ERRO: int = 500


# --- Funções "Públicas" ---

func acertou_nota() -> void:
	combo += 1
	pontuacao += pontuacao_por_acerto * combo
	
	# Agora recupera 2.0 de energia, até o máximo de 100
	energia = min(energia + GANHO_POR_ACERTO, ENERGIA_MAXIMA)
	
	pontuacao_atualizada.emit(pontuacao)
	combo_atualizado.emit(combo)
	energia_atualizada.emit(energia)
	
	if pontuacao >= pontos_para_proximo_nivel:
		avancar_nivel()

func errou_nota() -> void:
	combo = 0
	energia -= PERDA_POR_ERRO
	pontuacao = max(0, pontuacao - PONTOS_PERDIDOS_POR_ERRO) 
	
	combo_atualizado.emit(combo)
	energia_atualizada.emit(energia)
	pontuacao_atualizada.emit(pontuacao) 
	
	print("ERROU! Combo quebrado. Pontos perdidos! Energia: ", energia)
	
	if energia <= 0:
		energia = 0
		game_over.emit()
		print("GAME OVER")

func iniciar_jogo() -> void:
	pontuacao = 0
	combo = 0
	energia = ENERGIA_MAXIMA
	
	tabuada_atual = 2
	pontos_para_proximo_nivel = META_PONTOS_BASE 
	
	pontuacao_atualizada.emit(pontuacao)
	combo_atualizado.emit(combo)
	energia_atualizada.emit(energia)
	tabuada_atualizada.emit(tabuada_atual)

func avancar_nivel() -> void:
	
	if tabuada_atual >= 9:
		return
	
	tabuada_atual += 1
	pontos_para_proximo_nivel = META_PONTOS_BASE * (tabuada_atual - 1)
	tabuada_atualizada.emit(tabuada_atual)
	
	print("AVANÇOU DE NÍVEL! Múltiplos de: ", tabuada_atual)
	print("Próxima meta: ", pontos_para_proximo_nivel, " pontos")
