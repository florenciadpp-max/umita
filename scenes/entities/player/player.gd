extends CharacterBody3D

@onready var animated_sprite: AnimatedSprite3D = $AnimatedSprite3D

# Velocidad de movimiento (unidades por segundo).
# Ajusta este valor desde el editor si querés que el personaje vaya más rápido o más lento.
@export var base_speed := 10.0

# Velocidad de carrera (unidades por segundo).
# Se usa si querés implementar una tecla para correr.
@export var run_speed := 50.0

# Referencia a la cámara del juego.
# Se usa para que "adelante" del jugador coincida con hacia donde mira la cámara.
@onready var camera = $CameraController/Camera3D

# Entrada de movimiento en el plano horizontal.
# Vector2(x, y): x = izquierda/derecha, y = adelante/atrás. Valores entre -1 y 1.
var movement_input := Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Esta función se ejecuta en cada paso físico (no en cada frame de render).
	# 'delta' es el tiempo en segundos desde la última llamada: se usa para que el
	# movimiento sea consistente sin importar la velocidad de la máquina.
	complex_movement(delta)
	set_animation()
	# Aplica la velocidad calculada al cuerpo y gestiona colisiones automáticamente.
	move_and_slide()

func complex_movement(delta: float) -> void:
	# 1) Leemos la entrada del teclado (left/right/forward/backward).
	#    Entradas configuradas en Proyecto -> Configuración del Proyecto -> Mapa de Entrada.
	# 2) Rotamos esa entrada para que esté alineada con la cámara,
	#    así "adelante" siempre será hacia donde la cámara mira.
	movement_input = Input.get_vector("left", "right", "forward", "backward").rotated(-camera.global_rotation.y)
	# vel_2d contiene la velocidad actual en el plano horizontal (X,Z).
	var vel_2d = Vector2(velocity.x, velocity.z)
	
	var acceleration := 4.0 * delta

	# Comprobamos si el jugador está corriendo (tecla "run" presionada).
	var is_running = Input.is_action_pressed("run")

	if movement_input != Vector2.ZERO:
		# Si hay entrada de la tecla "run": calculamos la velocidad objetivo (camina o corre).
		var speed = run_speed if is_running else base_speed
		
		# Si hay entrada: aplicamos una aceleración suave.
		# Multiplicamos por 'delta' para que la aceleración dependa del tiempo.
		vel_2d += movement_input * speed * acceleration
		
		# Limitamos la magnitud para que no supere la velocidad máxima (speed).
		vel_2d = vel_2d.limit_length(speed)
		
		# Actualizamos la velocidad 3D conservando la componente vertical (Y),
		# que puede venir de la gravedad o de un salto.
		velocity = vec2_to_vec3(vel_2d, velocity.y)
	else:
		# Si no hay entrada: desaceleramos suavemente hacia cero.
		# Esto evita detenerse de golpe y da una sensación más natural.
		vel_2d = vel_2d.move_toward(Vector2.ZERO, base_speed * 4.0 * acceleration)
		velocity = vec2_to_vec3(vel_2d, velocity.y)

# Alternativa simple (sin aceleración). 
# Mueve al jugador instantáneamente según la entrada de la cámara.
# func simple_movement(delta: float) -> void:
#     movement_input = Input.get_vector("left", "right", "forward", "backward").rotated(-camera.global_rotation.y)
#     velocity = Vector3(movement_input.x, 0, movement_input.y) * base_speed

# Convierte un Vector2 (X,Z) en Vector3 respetando la altura (Y) dada.
# Usamos esto para combinar la velocidad horizontal con la velocidad vertical y evitar repetir código.
func vec2_to_vec3(v2: Vector2, y: float) -> Vector3:
	return Vector3(v2.x, y, v2.y)

func set_animation() -> void:
	var pressing_left := Input.is_action_pressed("left")
	var pressing_right := Input.is_action_pressed("right")
	var pressing_backward := Input.is_action_pressed("backward")
	
	if (pressing_left or pressing_right):
		animated_sprite.play("sidewalk")
		animated_sprite.flip_h = pressing_right
	elif pressing_backward:
		animated_sprite.play("backwalk")
	else:
		animated_sprite.play("idle")
