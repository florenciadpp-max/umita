# Umita — Proyecto Godot

Este repositorio contiene una pequeña escena de ejemplo para Godot (v4.x) con un jugador y un controlador de cámara.

Acá explico cómo abrir, probar el proyecto en Godot y dónde colocar los assets.

## Abrir el proyecto 

Antes de arrancar: cuando digo "clonar" me refiero a copiar el proyecto desde GitHub a tu PC. Es lo mismo que "descargar", pero permite que el proyecto permanezca conectado al repositorio (importante para que podamos integrar los assets que subamos).

IMPORTANTE: evitemos la opción de "Download ZIP" en GitHub — descargando el ZIP no vamos a quedar "conectados" al repositorio y después no podremos sincronizar cambios ni enviar actualizaciones fácilmente. Por favor usemos Git (o GitHub Desktop) para que todo el equipo trabaje sobre el mismo repositorio.

Opción recomendada — Con Git (o GitHub Desktop) en Windows

### 1. Instalar Git

- Descargá "Git for Windows" desde https://git-scm.com/ y ejecutá el instalador (aceptá las opciones por defecto).
- Si preferís interfaz gráfica en lugar de la terminal, podés instalar "GitHub Desktop" desde https://desktop.github.com/ (es más amigable, pero es ideal tener ambas).

### 2. Abrir PowerShell 

- Con la siguiente secuencia: tecla Windows → escribí "PowerShell" → Enter. También podemos abrir GitHub Desktop.

### 3. En PowerShell

- Cambiá a la carpeta donde quieras guardar el proyecto. 
    Ejemplo:
    ```powershell
    cd C:\Users\TuUsuario\Documentos\Godot\Proyectos
    ```

### 4. Clonar el repositorio (si usás PowerShell)

```powershell
git clone https://github.com/federicohermo/umita.git
cd umita
```

Si usás GitHub Desktop: abrí la app, elegí "File → Clone repository", pegá la URL `https://github.com/federicohermo/umita.git` y cloná en la carpeta que prefieras.

### 5. Si no tenés Godot instalado — cómo descargarlo y ejecutarlo

Si alguno del equipo aún no tiene el editor, acá van pasos rápidos para instalar/ejecutar Godot.

- Versión recomendada: Godot 4.4 (cualquier parche 4.4.x está bien). Evitar Godot 3.x o versiones mayores que no sean 4.x porque son incompatibles con este proyecto.
- Página oficial de descargas: https://godotengine.org/download

Pasos para Windows (rápido):

- Abrí la página de descargas y elegí la versión "Standard" para Windows (64-bit).
- Tenés dos opciones comunes:
	- Ejecutable / instalador (.exe / .msi): ejecutalo y seguí el asistente.
	- ZIP portátil: descargalo, extraelo y ejecutá `Godot.exe` (no requiere instalación).
- Una vez abierto Godot, elegí "Project → Open" o "Import" y seleccioná la carpeta del proyecto que contiene `project.godot` (la carpeta `umita`).

### 6. Abrir Godot

- Elegí "Open" o "Import" para abrir `project.godot` dentro de la carpeta `umita`.

### 7. Abrir la escena

- Abrí la escena de prueba `scenes/levels/level.tscn` y presioná Ejecutar (F5) o presionar en el botón con el ícono de play en la esquina superior derecha de la interfaz de usuario.

---

## Estructura relevante del proyecto (solo lo importante)

```
project.godot
README.md
scenes/
	entities/
		player/
			player.tscn
			player.gd
			camera_controller.tscn
			camera_controller.gd
	levels/
		level.tscn
```

- `scenes/entities/player/player.tscn` — escena del jugador.
- `player.gd` — script que controla el movimiento del personaje.
- `camera_controller.tscn` - escena del controlador de la cámara.
- `camera_controller.gd` — script que controla cómo rota la cámara con el mouse.

---

## Qué podemos hacer sin tocar código

- Ajustar valores desde el Inspector: los nodos que contienen `player.gd` y `camera_controller.gd` exponen variables que podemos modificar en el editor:
    - `base_speed` (velocidad base del jugador)
    - `run_speed` (velocidad al correr)
    - `mouse_acceleration` (sensibilidad de la cámara)
    - `min_limit_x` / `max_limit_x` (límite vertical de la cámara)

Podemos cambiarlos en tiempo de edición y probar con F5; no hace falta abrir los scripts.

---

## Dónde dejar assets (imágenes, modelos, audio)

DISCLAIMER: Todo esto es a modo de ejemplo, debemos definirlo en grupo.

Por ahora, agreguemos assets en carpetas claras dentro de `res://` (la raíz del proyecto):

- Texturas / sprites: `assets/images/` (formatos: PNG, WebP). Es preferible mantener transparencias en PNG.
- Modelos 3D: `assets/models/` (formatos: glTF (`.glb`) preferido, OBJ si hace falta).
- Audio: `assets/audio/` (WAV para efectos, OGG para música). Indicá si es estéreo/mono y el BPM para loops.

Convenciones y recomendaciones al entregar:
- Incluir un archivo README corto dentro de la carpeta del asset con la licencia y autor.
- Nombres sin espacios; usemos `snake_case` o `kebab-case` (ej: `player_idle.png`, `sfx_step_01.wav`).
- Para sprites: enviemos hojas de sprite separadas o PNGs individuales y especifiquemos el orden/frames.
- Para sonidos: indiquemos si deben reproducirse en bucle y el punto de inicio/fin del loop si corresponde.

Se pueden subir los archivos al repo o pasarlos por Drive/WeTransfer y los integramos.

---

## Inputs y controles

Las acciones de entrada usadas (podemos usarlas como referencia al probar):
- `left`, `right`, `forward`, `backward` — movimiento (w,a,s,d y flechas).
- `run` — correr (shift).

Esta configuración es provisoria.

---

## Notas técnicas mínimas

- Proyecto pensado para Godot 4.x (usa `CharacterBody3D`).
- El movimiento del jugador usa `Input.get_vector(...)` y se alinea con la dirección de la cámara.
- La cámara se controla con el mouse y tiene límites verticales configurables.

---
