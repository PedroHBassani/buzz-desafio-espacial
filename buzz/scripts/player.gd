extends CharacterBody2D

var speed = 350
var vidas = 3

func _ready() -> void:
	add_to_group("jogador")

func _process(delta):
	velocity = Vector2.ZERO

	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		velocity.x = -speed
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		velocity.x = speed

	move_and_slide()

	var screen_size = get_viewport_rect().size
	position.x = clamp(position.x, 0, screen_size.x)

func perder_vida():
	vidas -= 1
	print("Vidas restantes:", vidas)
	
	var ui = get_node("../UI")
	ui.atualizar_coracoes(vidas)

	if vidas <= 0:
		print("Game Over!")
		queue_free()
