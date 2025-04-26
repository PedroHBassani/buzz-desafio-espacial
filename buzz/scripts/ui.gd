extends CanvasLayer

var coracoes = []

func _ready():
	coracoes = $"Corações".get_children()

func atualizar_coracoes(qtd_vidas: int):
	for i in range(coracoes.size()):
		coracoes[i].visible = i < qtd_vidas
