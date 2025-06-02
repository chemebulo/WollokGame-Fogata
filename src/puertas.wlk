import wollok.game.*
import escenarios.*
import videojuego.*
import protagonista.*
import direccion.*
import visualesExtra.*

// ###############################################################################################

class Puerta inherits Visual{
    var property image = "puerta.png" 
    var property position = game.origin() 
    var property irHacia 
    override method esAtravesable() = true
}

// ###############################################################################################

class PuertaAbierta inherits Puerta  {
    method interaccion() {
      videojuego.cambiarEscenario(irHacia)
    }
}

// ###############################################################################################

class PuertaCerrada inherits Puerta {
    var property mensaje

    method interaccion() {
      game.say(protagonista, mensaje)
    }
}

// ###############################################################################################


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