import wollok.game.*
import protagonista.*
import visualesExtra.*
import enemigos.*

// #############################################################################################################################

class Escenario{ 
    /*
        INV .REP: En eventos, cada evento de la lista se llama EXACTAMENTE IGUAL que los eventos que se implementan en eventos Iniciar,
        véase ejemplo en ISSUE en github
    
    */
    const pj = protagonista
    const gestorFondo = fondo     
    var property eventos = []
    var property mapa = []
    var property fondoEscenario = ""
    var property visualesEnEscena = []
    var property ost = game.sound("")
    var property dialogo = [] // [npcActual, dialogo] implementar en dialogos.wlk
    var property confgActual = {} // Un bloque en configuradorEscenarios.wlk
    var property confgEscSiguiente = {}
    const gestorEvento = gestorDeEventos

    method puestaEnEscena(){ 
        self.configurar()
         self.configurarEscenarioSiguiente()
         ost.shouldLoop(true)
         ost.play()
         self.dibujarFondo()
         self.configurarConversacion()
         self.dibujarTablero()
         self.agregarVisualesEscena()
         self.colisionesYEventos()
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
    method dibujarFondo(){
        gestorFondo.visualizarFondo(fondoEscenario)
    }
   
   method colisionesYEventos(){
       self.colisiones()
       self.eventosIniciar()
   }

    method configurarEscenarioSiguiente(){
        confgEscSiguiente.apply()
    }

    method colisiones(){
         game.onCollideDo(pj, {objeto => objeto.interaccion()})
    }


    method eventosIniciar(){ 
       
        gestorEvento.gestionar(eventos.isEmpty(),{eventos.forEach({ev =>ev.iniciarEvento()})} )
    } 

    method eventosFinalizar(){
       
        gestorEvento.gestionar(eventos.isEmpty(),{ eventos.forEach({ev => ev.finalizarEvento()})} )
    }

    

    method agregarVisualesEscena(){
        visualesEnEscena.forEach({v => game.addVisual(v)})
    } 

    method configurarConversacion(){ 

        if(not dialogo.isEmpty()){
            
            pj.npcActual(self.npcEscenario())
            pj.conversacionNPC(self.dialogoActual())
         
        }
        

    }
    method dialogoActual() = dialogo.last().copy()

    method npcEscenario() = dialogo.first()

    method limpiar(){
        game.removeVisual(fondo)
        self.limpiarVisualesEnEscena()
        ost.stop()
        self.eventosFinalizar()
        pj.resetearDialogo()
        self.resetearEventosyDialogos() // evita tener que settear en los configuradores que los dialogos 
                                        // y eventos esten vacios, sino quedan los dialogos y eventos del escenario anterior
     }

    method limpiarVisualesEnEscena(){
        visualesEnEscena.forEach({v => game.removeVisual(v)})
    }

    method resetearEventosyDialogos(){
        dialogo = []
        eventos = []
    }
}

// #############################################################################################################################

object fondo{
    /* 
        INVARIANTE DE REPRESENTACIÓN: 
            * La imagen tiene el tamaño del tablero 1300px(ancho) x 900px(alto).
    */
    var property position = game.at(0,0)
    var property image = ""

    
    method visualizarFondo(fondoEscenario){
        image = fondoEscenario
        game.addVisual(self)    
    }

    method esAtravesable() = true

    method interaccion(){}
}

object gestorDeEventos {

    method gestionar(condicion, bloque){
        if(not condicion){
            bloque.apply()
        }
    }

}