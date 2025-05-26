import wollok.game.*
import protagonista.*
import visualesExtra.*
import enemigos.*

// #############################################################################################################################

class Escenario{ 

    const gestorFondo = fondo    
    const gestorFondo =  fondo    
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

    method configurarPuertas(){ // Implementar.

    } 

    method colisiones(){
         game.onCollideDo(protagonista, {objeto => objeto.interaccion()})
    }


    method eventosIniciar(){ // Sobreescribir metodo si hay eventos,usar los Tick.

    } 

    method eventosFinalizar(){
        eventos.forEach({evento => game.removeTickEvent(evento)})

    } 

    method agregarVisualesEscena(){
        visualesEnEscena.forEach({v => game.addVisual(v)})
    } 

    method configurarConversacion(){ // Solo sobreescribir si hay conversacion.

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