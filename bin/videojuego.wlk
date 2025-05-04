

import wollok.game.*
import protagonista.*
import direccion.*
import escenarios.*

object videojuego{
    
    /*
        LOGICA: 
            existe una variable escenario que al hacer videojuego.iniciar() coloca toods los elementos de ese escenario.
            La idea es que cuando interactue con la puerta, el escenario cambie a otro escenario
            VÉASE escenarios.wlk
    */

    var property escenario = escenarioInicial

    method iniciar(){
        escenario.puestaEnEscena()
    }

    method cambiarEscenario(nuevoEscenario){
        escenario.limpiar()
        escenario = nuevoEscenario
        self.iniciar()
    }

    //----------tablero------------------
    method tablero(){
        game.width(13)
        game.height(9)
	    game.cellSize(100)
        
    }

    // --CONTROLES------------
    method controles(){

        keyboard.w().onPressDo({protagonista.mover(arriba)})
        keyboard.a().onPressDo({protagonista.mover(izquierda)})
        keyboard.s().onPressDo({protagonista.mover(abajo)})
        keyboard.d().onPressDo({protagonista.mover(derecha)})

        
    }


}