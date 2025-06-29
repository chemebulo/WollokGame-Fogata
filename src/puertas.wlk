import videojuego.*
import protagonista.*
import visualesExtra.*
import direccion.*
import escenariosManager.*

class Puerta inherits Visual(image = null, position = game.origin()){
    //	Se descarto lo de la puerta cerrada. Se requiere quitar la funcionalidad
    //	Se recomienda pasar la herencia a visualInteractuable, y pasar la interaccion a un bloque como en esa clase
    //	Lo mismo con la puerta especial.
    var property irHacia       = fogata // Por defecto.
    const property estaCerrada = false
    const direccion            = null
	
    // ========================================================================================================= \\

    override method esAtravesable(){
		return true
	} 

   	override  method interaccion(){
      	self.validarInteraccion()
        const imagenRetorno = protagonista.imagenNueva(direccion)
        protagonista.image(imagenRetorno) // para que al atravesar la puerta el prota quede con la imagen bien
      	videojuego.cambiarEscenario(irHacia)
    }

    method validarInteraccion(){
      	if (estaCerrada){
      	  	//self.error("No puedo tomar este camino") // esto para el juego 
            game.say(protagonista,"No puedo tomar este camino")
      	}
    }
}

// ############################################################################################################# \\

class PuertaEspecial inherits Puerta{
  	override method interaccion(){
       self.validarInteraccion()
       videojuego.cambiarEscenario(irHacia)
  	}
}

// ############################################################################################################# \\

const puertaNorte = new Puerta(direccion = arriba,    image = "puerta.png", position = norte.ubicacion())    
const puertaOeste = new Puerta(direccion = izquierda, image = "puerta.png", position = oeste.ubicacion())
const puertaEste  = new Puerta(direccion = derecha,   image = "puerta.png", position = este.ubicacion())
const puertaSur   = new Puerta(direccion = abajo,     image = "puerta.png", position = sur.ubicacion())

const puertaEntradaCabaña = new PuertaEspecial(image = "puerta-cabaña.png",  irHacia = cabaña)
const puertaEntradaCueva  = new PuertaEspecial(image = "puerta-cueva.png",   irHacia = cueva)
const puertaGranero       = new PuertaEspecial(image = "puerta-granero.png", irHacia = granero)

// ############################################################################################################# \\