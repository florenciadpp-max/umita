extends Node3D

# Límite mínimo/ máximo para la rotación vertical (eje X).
# Evita que la cámara mire demasiado arriba o abajo.
@export var min_limit_x := -1.0
@export var max_limit_x := 0.1

# Sensibilidad del movimiento del mouse.
# Multiplicá el movimiento del cursor para ajustar qué tan rápido rota la cámara.
@export var mouse_acceleration := 0.005

# Se llama cuando llega un evento de entrada (mouse, teclado, etc.).
# Acá sólo reaccionamos al movimiento del mouse para rotar la cámara.
func _input(event: InputEvent) -> void:
	# event.relative es el cambio de posición del mouse desde el último evento.
	# Lo multiplicamos por mouse_acceleration para controlar la sensibilidad.
	if event is InputEventMouseMotion:
		rotate_from_vector(event.relative * mouse_acceleration)

# Rota la cámara usando un Vector2 (x = horizontal, y = vertical).
# - v.x  cambia la rotación horizontal (giro alrededor de Y).
# - v.y  cambia la rotación vertical (inclinación alrededor de X).
# Aplicamos un clamp a la rotación X para que la cámara no de un giro de 360 grados.
# Tengamos en cuenta que al restar v.y invertimos el movimiento vertical del mouse
# por lo que min_limit_x es el límite superior y max_limit_x el límite inferior.
func rotate_from_vector(v: Vector2):
	if v.length() == 0: return
	rotation.y -= v.x
	rotation.x -= v.y
	rotation.x = clamp(rotation.x, min_limit_x, max_limit_x)
