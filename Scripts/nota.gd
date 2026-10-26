extends Area2D

@export var velocidade: float = 200.0

# --- NOVAS VARIÁVEIS AQUI ---

# Esta variável vai guardar se a nota é uma resposta "Certa" ou "Errada"
var e_correta: bool = false

# Esta variável vai guardar o número que a nota representa (ex: 14, 21, 25)
var valor: int = 0

# --- FIM DAS NOVAS VARIÁVEIS ---


# _process é chamado a cada frame (isto não muda)
func _process(delta: float) -> void:
	position.y += velocidade * delta


# --- NOVA FUNÇÃO AQUI ---

# Esta é uma função que o GeradorDeNotas vai chamar
# para "configurar" a nota assim que ela for criada.
func configurar(numero: int, correta: bool) -> void:
	
	# 1. Guarda os valores nas nossas variáveis
	valor = numero
	e_correta = correta
	
	# 2. Atualiza o texto do nó "Label"
	#    Certifique-se de que seu nó Label dentro de Nota.tscn
	#    se chama exatamente "Numero" (com 'N' maiúsculo).
	#    Se o nome for diferente, ajuste a linha abaixo.
	$Numero.text = str(valor)
