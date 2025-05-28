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
    const gestorFondo = fondo     
    const eventos = []
    const mapa
    const fondoEscenario
    const visualesEnEscena 
    const ost

    method puestaEnEscena(){ 

         ost.shouldLoop(true)
         ost.play()
         self.dibujarFondo()
         self.configurarPuertas()
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

    method dibujarFondo(){
        gestorFondo.visualizarFondo(fondoEscenario)
    }
   
   method colisionesYEventos(){
       self.colisiones()
       self.eventosIniciar()
   }

    method configurarPuertas(){}

    

    method colisiones(){
         game.onCollideDo(protagonista, {objeto => objeto.interaccion()})
    }


    method eventosIniciar(){ 
        eventos.forEach({evento =>evento.iniciarEvento()})
    } 

    method eventosFinalizar(){
        eventos.forEach({evento => game.removeTickEvent(evento.nombreEvento())})

    } 

    method agregarVisualesEscena(){
        visualesEnEscena.forEach({v => game.addVisual(v)})
    } 

    method configurarConversacion(){ 

    }

    method limpiar(){
        game.removeVisual(fondo)
        self.limpiarVisualesEnEscena()
        ost.stop()
        self.eventosFinalizar()
    }

    method limpiarVisualesEnEscena(){
        visualesEnEscena.forEach({v => game.removeVisual(v)})
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