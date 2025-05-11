import wollok.game.*
import protagonista.*
import direccion.*
import escenarios.*

object videojuego{

    var property escenario = escenarioInicial

    

    
    method iniciar(){ 
        escenario.puestaEnEscena()
    }

    method cambiarEscenario(escenarioNuevo){ // cambia a otro escenario
        escenario.limpiar()
        self.escenario(escenarioNuevo)
        escenario.puestaEnEscena()
        
    }
   

    // ############################### TABLERO ###############################
    
    method tablero(){
        game.width(13)
        game.height(9)
	    game.cellSize(100)
    }

    // ############################## CONTROLES ##############################
    
    method controles(){
        keyboard.w().onPressDo({protagonista.mover(arriba)})
        keyboard.a().onPressDo({protagonista.mover(izquierda)})
        keyboard.s().onPressDo({protagonista.mover(abajo)})
        keyboard.d().onPressDo({protagonista.mover(derecha)})
    }
}