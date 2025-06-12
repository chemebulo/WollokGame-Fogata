import protagonista.*
import gestores.*

// #############################################################################################################################

class Escenario{ 
    /*
        INV .REP: En eventos, cada evento de la lista se llama EXACTAMENTE IGUAL que los eventos que se implementan en eventos Iniciar,
        véase ejemplo en ISSUE en github
    */
    var property eventos = []
    var property mapa = []
    var property fondoEscenario = ""
    var property visualesEnEscena = []
    var property ost = game.sound("")
    var property dialogo = [] // [npcActual, dialogo] implementar en dialogos.wlk
    var property confgActual = {} // Un bloque en configuradorEscenarios.wlk
    var property confgEscSiguiente = {}
   
    const gestorFondo  = gestorFondoEscenario
    const gestorEvento = gestorDeEventos
    const gestorObs    = gestorDeObstaculos
    const gestorLobos = gestorDeLobos
    const limpiadorEscenario = gestorDeLimpiezaEscenarios
    const gestorDialogo = gestorConversaciones
    
    method puestaEnEscena(){ 
        self.configurar()
        self.configurarEscenarioSiguiente()
        ost.shouldLoop(true)
        ost.play()
        gestorFondo.visualizarFondo(fondoEscenario)
        gestorDialogo.configurarConversacion(self)
        self.dibujarTablero()
        self.agregarVisualesEscena()
        gestorEvento.gestionarInicio(eventos)
    }
    
    method dibujarTablero() {
         (0 .. game.width() - 1).forEach({x =>  
            (0 .. game.height() - 1).forEach( {y => 
                const constructor = mapa.get(y).get(x)
                constructor.construir(game.at(x, y))
            })
        })
    }

    method configurar(){
        confgActual.apply(self)
    }
 
    method configurarEscenarioSiguiente(){
        confgEscSiguiente.apply()
    }

    method agregarVisualesEscena(){
        visualesEnEscena.forEach({v => game.addVisual(v)})
    } 
  
    method limpiar(){     
        gestorFondo.borrarFondo()
        ost.stop()
        limpiadorEscenario.limpiar(self)
        gestorEvento.gestionarFin(eventos);
         gestorObs.limpiarObstaculos()
        protagonista.resetearDialogo()
        gestorLobos.limpiarLobos()

     }

    method limpiarVisualesEnEscena(){
        visualesEnEscena.forEach({visual => game.removeVisual(visual)})
    }

    method hayDialogo(){
        return not dialogo.isEmpty()
    }
}    

// #############################################################################################################################