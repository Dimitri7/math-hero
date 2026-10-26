extends Area2D

@export var acao_de_input: StringName
var nota_na_area: Area2D = null

# --- 1. Carregamos a cena da Explosão ---
# Certifique-se que o arquivo "Explosao.tscn" está na pasta "Cenas"
# Se estiver em outra pasta, corrija o caminho abaixo.
const CENA_EXPLOSAO = preload("res://Cenas/explosao.tscn") 

# Variáveis para a animação do botão
var escala_original: Vector2 = Vector2(1, 1)
var cor_modulate_original: Color = Color(1, 1, 1, 1)

func _ready() -> void:
	escala_original = scale
	cor_modulate_original = modulate


func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed(acao_de_input):
		
		# Animação visual do botão (pular)
		animar_clique()
		
		if nota_na_area != null:
			# Se acertou a nota correta (matemática)
			if nota_na_area.e_correta == true:
				GameManager.acertou_nota()
				modulate = Color.GREEN 
				
				# --- AQUI ESTÁ O PASSO 4 ---
				# Chamamos a função para criar o efeito visual
				criar_explosao()
				# ---------------------------
				
			else:
				# Se acertou uma nota errada (obstáculo)
				GameManager.errou_nota()
				modulate = Color.RED
			
			# Destrói a nota
			nota_na_area.queue_free()
			nota_na_area = null
			
		else:
			# Se apertou no vazio
			GameManager.errou_nota()
			modulate = Color.RED


# Função para animar o botão "pulando"
func animar_clique() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", escala_original * 1.2, 0.05)
	tween.tween_property(self, "scale", escala_original, 0.1)
	tween.tween_property(self, "modulate", cor_modulate_original, 0.2)


# --- A FUNÇÃO QUE CRIA A EXPLOSÃO ---
func criar_explosao() -> void:
	# 1. Cria uma cópia da cena de explosão
	var explosao = CENA_EXPLOSAO.instantiate()
	
	# 2. Adiciona essa explosão na cena do jogo
	# (get_tree().current_scene pega a raiz do jogo atual)
	get_tree().current_scene.add_child(explosao)
	
	# 3. Coloca a explosão na MESMA posição deste Receptor
	explosao.global_position = self.global_position


# Funções de detecção de área (padrão)
func _on_area_entered(area: Area2D) -> void:
	nota_na_area = area

func _on_area_exited(area: Area2D) -> void:
	if area == nota_na_area:
		if nota_na_area.e_correta == true:
			GameManager.errou_nota()
		nota_na_area = null
