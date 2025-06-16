import protagonista.*
import direccion.*
import escenarios.*
import visualesExtra.*
import diapositivasManager.*


object videojuego{  
   
    var property escenario  = entradaCueva
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
         self.finalizarYMostrar(gameover,"gameover.mp3")
    }

    method juegoGanado(){      
        self.finalizarYMostrar(juegoGanado,"game-win.mp3")
    }
    
    method finalizarYMostrar(visual,sonido){
         escenario.limpiar()
        game.clear();
        game.addVisual(visual); 
        game.sound(sonido).play()
        game.onTick(5000,"fin",{game.stop()})
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
        keyboard.e().onPressDo({protagonista.interactuarNPC()})
        keyboard.f().onPressDo({gestorDeDiapositivas.interactuarDiapositivas()})
        keyboard.m().onPressDo({game.stop()})
        keyboard.y().onPressDo({self.juegoGanado()})
        keyboard.k().onPressDo({protagonista.atacar()})
    }

    // ################### Metodo para manejo de diapositivas ##################

    method culminarDiapositivasYContinuar(bloque){
        bloque.apply(self,gestorDiapositivas)
    }
}