import videojuego.*
import protagonista.*
import visualesExtra.*
import direccion.*
import escenarios.*

// ###############################################################################################

class Puerta inherits Visual{
    var property image         = null
    var property position      = game.origin() 
    var property irHacia 
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

const puertaNorte = new Puerta(direccion=arriba,image = "puerta.png",position = norte.ubicacion(), irHacia = escenarioInicial)    
const puertaOeste = new Puerta(direccion=izquierda,image = "puerta.png",position = oeste.ubicacion(), irHacia = escenarioInicial)
const puertaEste  = new Puerta(direccion=derecha,image = "puerta.png",position = este.ubicacion() , irHacia = escenarioInicial)
const puertaSur   = new Puerta(direccion=abajo,image = "puerta.png",position = sur.ubicacion()  , irHacia = escenarioInicial)

const puertaEntradaCabaña = new PuertaEspecial(image = "puerta.png", irHacia= escenarioCabañaInicial)
const puertaEntradaCueva = new PuertaEspecial(image ="puerta.png",irHacia = escenarioCueva)
const puertaGranero = new PuertaEspecial(image = "puerta.png",irHacia= escenarioGranero)
/*
  REQUERIMIENTOS:
    * 4 objetos PuertaAbierta para poder dibujarlas en el escenario solo seteando el "irHacia"
        (la ubicacion sera responsabilidad del creador de escenarios(las dibuja con la matriz).
  
    * 4 objetos PuertaCerrada para que sean las puertas cerradas que devuelven mensajes al interactuar
        (depende el escenario se setea el mensaje).
  
    * 1 o 2 puertas genericas para que sean la entrada a la cabaña,cueva,granero,etc
            (se les setearia irHacia a un escenario para cada lugar, a veces ya no se podra entrar al 
            granero o cabaña dependiendo la historia).
  
    * Todos estos objetos deben instanciarse al principio del archivo escenarios.
  
    * Decidir si se dibujan en la matriz (implementar todos los objetos en escenarioManager) o 
      si no se dibujan en la matriz y solo se agregan como visuales, pero NO SE PUEDE dibujar
      nada en la posicion que tendrian en la matriz.
  
    * En algunos escenarios hay conversaciones o cosas para hacer, buscar la forma de que de momento
      las puertas esten cerradas hasta que se cumpla lo que ocurre en el mapa.(solucionado)
*/ 