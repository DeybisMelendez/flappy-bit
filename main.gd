extends Node2D

var pajaro = preload ("res://obj/pajaro.tscn")
var tubo = preload ("res://obj/tuberia.tscn") #El objeto tuberia se precarga
var tuboPos = [ # 3 posibles posiciones para la tuberia
	Vector2(60,43), #posicion 1
	Vector2(60,30), #posicion 2
	Vector2(60,20) #posicion 3
]
var random = randi()%3 #conseguimos un numero random con el que elegimos la posicion de la tuberia
var tuboCreado = null #Esta variable sirve para obtener el objeto tuberia cuando se coloque en la escena
var pajaroCreado = null
var puntaje = 0 # El valor del puntaje
var crearPajaro = true
func _ready():
	get_node("puntaje/puntaje").hide()

func _process(delta):
	
	if global.comienzaJuego and crearPajaro: #Colocamos el pajaro en la partida
		crearPajaro = false
		get_node("puntaje/puntaje").show() #mostramos el puntaje cuando empiece la partida
		get_node("puntaje/titulo").hide() #ocultamos el titulo del juego
		get_node("puntaje/titulo2").hide()
		var nuevoPajaro = pajaro.instance()
		nuevoPajaro.position = Vector2(20,20)
		add_child(nuevoPajaro)
		pajaroCreado = (get_child(get_child_count()-1)).get_name()
		crearTubo() #creamos la primer tuberia del juego
	
	if tuboCreado != null: #Revisamos si se ha creado la tuberia
		if get_node(tuboCreado).global_position.x < get_node(pajaroCreado).global_position.x: # Cuando la tuberia pasa el pajaro
			puntaje += 1 #sumamos un punto
			get_node("puntaje/puntaje").set_text(str(puntaje)) #actualizamos en pantalla el puntaje
			crearTubo() #Creamos una nueva tuberia
			get_node("sonidoPunto").play()

func crearTubo(): # Proceso para crear la tuberia
	random = randi()%3
	var tuboNuevo = tubo.instance()
	tuboNuevo.position = tuboPos[random]
	add_child(tuboNuevo)
	tuboCreado = (get_child(get_child_count()-1)).get_name()