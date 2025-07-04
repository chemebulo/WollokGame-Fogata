import videojuego.*
import protagonista.*
import visualesExtra.*
import direccion.*
import escenariosManager.*

// #################################################################################################################################### \\

class Puerta inherits VisualInteractuable(image = "puerta.png", bloqueInteraccion = puertaBloque, position = game.origin()){
    var property irHacia = fogata // Por defecto.
}

// #################################################################################################################################### \\

class PuertaEspecial inherits Puerta{}

// #################################################################################################################################### \\

const puertaNorte = new Puerta(position = norte.ubicacion())    
const puertaOeste = new Puerta(position = oeste.ubicacion())
const puertaEste  = new Puerta(position = este.ubicacion())
const puertaSur   = new Puerta(position = sur.ubicacion())

const puertaEntradaCabaña = new PuertaEspecial(image = "puerta-cabaña.png",  irHacia = cabaña)
const puertaEntradaCueva  = new PuertaEspecial(image = "puerta-cueva.png",   irHacia = cueva)
const puertaGranero       = new PuertaEspecial(image = "puerta-granero.png", irHacia = granero)

// #################################################################################################################################### \\

const puertaBloque = {puerta => videojuego.cambiarEscenario(puerta.irHacia())}

// #################################################################################################################################### \\