import protagonista.*
import direccion.*
import escenarios.*
import visualesExtra.*
import diapositivasManager.*

object videojuego{
    const gestorDiapositiva     = gestorDeDiapositivas
    var property ostJuego       = game.sound("inicio-v1.png")
    var property escenario      = inicioJuego// cambiar a inicio juego
    var property estoyEnPrologo = true // settear a true 
    var property estoyEnGranero = false
    var property escenaAmigaMuerta =false
    var property estoyEnFinalJuego = false
   
    method stopMusica(){
        ostJuego.stop()
    }
    method iniciar(){ 
        escenario.puestaEnEscena()
    }

    method cambiarEscenario(escenarioNuevo){ 
        escenario.limpiar()
        self.escenario(escenarioNuevo)
        escenario.puestaEnEscena()
    }

    method finalizarJuego(){
        escenario.limpiar()
        game.clear();
        game.addVisual(gameover); 
        game.sound("gameover.mp3").play();
        game.onTick(5000,"fin",{game.stop()})

    }

    method juegoGanado(){
        escenario.limpiar();
        game.clear()
        game.addVisual(juegoGanado);
        game.sound("game-win.mp3").play()
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
        keyboard.f().onPressDo({self.interactuarDiapositias()})
        keyboard.m().onPressDo({game.stop()})
        keyboard.y().onPressDo({self.juegoGanado()})
        keyboard.k().onPressDo({protagonista.atacar()})
    }

    // ################### Metodos para manejo de diapositivas ##################

    method interactuarDiapositias(){
        if(estoyEnPrologo ||  escenaAmigaMuerta || estoyEnGranero || estoyEnFinalJuego){ 
            gestorDiapositiva.gestionarDiapositivas()
        }
    }

    method culminarDiapositivasYContinuar(bloque){
        bloque.apply(self)
    }
}