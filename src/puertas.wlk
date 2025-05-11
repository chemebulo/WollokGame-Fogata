import wollok.game.*
import escenarios.*
import videojuego.*
import protagonista.*
import direccion.*

class Puerta {
    var property image = "puerta.png" 
    var property position = game.origin() 
    var property irHacia 

}

class PuertaAbierta inherits Puerta  {
  
  method interaccion() {
    videojuego.cambiarEscenario(irHacia)
  }
}

class PuertaCerrada inherits Puerta {
  var property mensaje

  method interaccion() {
    game.say(protagonista, mensaje)
  }
}
