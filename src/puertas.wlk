import wollok.game.*
import escenarios.*
import videojuego.*
import protagonista.*
import direccion.*
import elementos.*

class Puerta inherits Visual{
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
/*
  REQUERIMIENTOS:
   * 4 objetos PuertaAbierta para poder dibujarlas en el escenario solo seteando el "irHacia"
        (la ubicacion sera responsabilidad del creador de escenarios(las dibuja con la matriz)

   * 4 objetos PuertaCerrada para que sean las puertas cerradas que devuelven mensajes al interactuar
        (depende el escenario se setea el mensaje)

   * 1 o 2 puertas genericas para que sean la entrada a la cabaña,cueva,granero,etc
        (se les setearia irHacia a un escenario para cada lugar, a veces ya no se podra 
         entrar al granero o cabaña dependiendo la historia)

  * En escenario.wlk implementar en seccion "ELEMENTOS PARA CONSTRUIR EL MAPA " los objetos : 
              *pAo,pAn,pAe,pAs (las puertas ABIERTAS con las 4 direcciones)
              *pCo,pCn,pCe,pCs (las puertas CERRADAS con las 4 direcciones)
              *puertas genericas 
                                               
*/ 