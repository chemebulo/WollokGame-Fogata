import protagonista.*
import direccion.*
import escenariosManager.*
import visualesExtra.*
import diapositivasManager.*
import dialogosManager.*

object videojuego{  
    var property escenario   = inicio
    const gestorDiapositivas = gestorDeDiapositivas
    
    method iniciar(){ 
        escenario.puestaEnEscena()
    }

    method cambiarEscenario(escenarioNuevo){ 
        escenario.limpiar()
        self.escenario(escenarioNuevo)
        escenario.puestaEnEscena()
    }

    method finalizarJuego(){      
        self.finalizarYMostrar(gameover,track_game_over)
    }

    method juegoGanado(){      
        self.finalizarYMostrar(juegoGanado,track_win)
    }
    
    method finalizarYMostrar(visual,sonido){
        escenario.limpiar()
        game.clear()
        game.addVisual(visual) 
        game.sound(sonido).play()
        game.onTick(5000, "fin", {game.stop()})
    }

    // ############################### TABLERO ###############################
    
    method tablero(){
        game.width(13)
        game.height(9)
        game.cellSize(100)
        game.onCollideDo(protagonista, {objeto => objeto.interaccion()})
    }

    // ############################## CONTROLES ##############################
    
    method controles(){
        keyboard.w().onPressDo({protagonista.mover(arriba)})
        keyboard.a().onPressDo({protagonista.mover(izquierda)})
        keyboard.s().onPressDo({protagonista.mover(abajo)})
        keyboard.d().onPressDo({protagonista.mover(derecha)})
        keyboard.e().onPressDo({gestorDeDialogo.interactuarNPC()})
        keyboard.f().onPressDo({gestorDeDiapositivas.interactuarDiapositivas()})
        keyboard.m().onPressDo({game.stop()})
        keyboard.k().onPressDo({protagonista.atacar()})
        keyboard.l().onPressDo({game.say(protagonista,game.allVisuals().toString())}) 
        // L: para testear, se borrara antes de entrega
        
    }

    // ################### Metodo para manejo de diapositivas ##################

    method culminarDiapositivasYContinuar(bloque){
        bloque.apply(self,gestorDiapositivas)
    }
}