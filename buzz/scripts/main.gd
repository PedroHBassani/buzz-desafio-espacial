extends Node2D

var planetas = [
	preload("res://assets/planets/earth.png"),
	preload("res://assets/planets/jupiter.png"),
	preload("res://assets/planets/mars.png"),
	preload("res://assets/planets/mercury.png"),
	preload("res://assets/planets/neptune.png"),
	preload("res://assets/planets/saturn.png"),
	preload("res://assets/planets/sun.png"),
	preload("res://assets/planets/uranus.png"),
	preload("res://assets/planets/venus.png")
]

var velocidade = 150
var tempo_geracao = 2.0  # Intervalo inicial entre a geração dos planetas

func gerar_planeta():
	var planeta = Area2D.new()
	var sprite = Sprite2D.new()
	sprite.texture = planetas[randi() % planetas.size()]
	planeta.add_child(sprite)

	var shape = CollisionShape2D.new()
	shape.shape = CircleShape2D.new()
	shape.shape.radius = 32
	planeta.add_child(shape)

	var x_pos = randf_range(0, 1024)
	planeta.position = Vector2(x_pos, -5)

	planeta.add_to_group("planetas")
	add_child(planeta)

	planeta.body_entered.connect(func(body):
		if body.is_in_group("jogador"):
			body.perder_vida()
			planeta.queue_free()  # Remove o planeta quando colide
	)
	# Aumenta a velocidade a cada geração de planeta
	velocidade = velocidade * 1.02  # Aumento mais suave, mas ainda progressivo
	tempo_geracao = max(0.4, tempo_geracao * 0.4)  # Aumenta a frequência com que planetas são gerados

	# Atualiza o tempo do Timer
	$Timer.wait_time = tempo_geracao

func _ready():
	randomize()
	$Timer.timeout.connect(_on_Timer_timeout)
	$Timer.start()

func _on_Timer_timeout():
	gerar_planeta()

func _process(delta):
	for planeta in get_tree().get_nodes_in_group("planetas"):
		planeta.position.y += velocidade * delta
		if planeta.position.y > get_viewport_rect().size.y + 40:
			planeta.queue_free()
