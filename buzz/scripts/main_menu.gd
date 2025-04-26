extends Control

func _ready():
	$VBoxContainer/Entrar.pressed.connect(_on_jogar_pressed)
	$VBoxContainer/Sair.pressed.connect(_on_sair_pressed)

func _on_jogar_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn") # substitua pelo caminho da sua cena do jogo

func _on_sair_pressed():
	get_tree().quit()
