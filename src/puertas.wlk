import videojuego.*
import protagonista.*
import visualesExtra.*
import direccion.*
import escenarios.*

// ###############################################################################################

class Puerta inherits Visual{

  /*
    Se descarto lo de la puerta cerrada.Se requiere quitar la funcionalidad
  */
    var property image         = null
    var property position      = game.origin() 
    var property irHacia       = fogata // por defecto
    const property estaCerrada = false
    const direccion = null
	
    override method esAtravesable(){
		return true
	} 

    method interaccion(){
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
class PuertaEspecial inherits Puerta{
  override method interaccion(){
      self.validarInteraccion()
      videojuego.cambiarEscenario(irHacia)
  }
}

// #################################################################### PUERTAS PARA TODO EL JUEGO ####################################################################

const puertaNorte = new Puerta(direccion=arriba,image = "puerta.png",position = norte.ubicacion())    
const puertaOeste = new Puerta(direccion=izquierda,image = "puerta.png",position = oeste.ubicacion())
const puertaEste  = new Puerta(direccion=derecha,image = "puerta.png",position = este.ubicacion() )
const puertaSur   = new Puerta(direccion=abajo,image = "puerta.png",position = sur.ubicacion()  )

const puertaEntradaCabaña = new PuertaEspecial(image = "puerta.png", irHacia= cabaña)
const puertaEntradaCueva = new PuertaEspecial(image ="puerta.png",irHacia = cueva)
const puertaGranero = new PuertaEspecial(image = "puerta.png",irHacia= granero)
