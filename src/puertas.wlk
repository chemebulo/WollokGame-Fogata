import wollok.game.*
import escenarios.*
import videojuego.*

class Puerta {
    var property image //"puerta.png" 
    var property position = game.origin() 
    var property irHacia //comedor.iniciar()


    method ubicarEn(unaUbicacion) {
        self.position(unaUbicacion)  
  }

    method interaccion() {
        videojuego.cambiarEscenario(irHacia)
  }
}
