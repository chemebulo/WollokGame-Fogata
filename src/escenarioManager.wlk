import wollok.game.*
import protagonista.*
import elementos.*
import enemigos.*

//##############ELEMENTOS PARA CONSTRUIR EL MAPA #############
class Elemento{ //REFERENCIAS A LOS DISTINTOS VISUALES APRA SETTEARSUS POSICIONES EN LAS MATRIZ O INSTANCIARLOS
    const visual = null
    method construir(position){
        visual.position(position)
    }
}


object _ inherits Elemento{
    override method construir(position){} //por las dudas
}
object z inherits Elemento(visual=protagonista){} 

object f inherits Elemento(visual=fogata){}

object c inherits Elemento(visual=carpa){}

object a inherits Elemento(visual=amiga){}
   
// IMPLEMENTAR...
object l inherits Elemento(){  //LOBO implementar 
    override method construir(posicion){
        
    }
}

object g inherits Elemento{ // guardabosques.No implementado, no usar
    override method construir(_position){}
}





class Escenario{ 
 
    const gestorFondo =  fondo    
  
    const mapa
    const fondoEscenario
    const visualesEnEscena 
    const ost

    method puestaEnEscena(){ // los que no se usan, sobreescribir el metodo en cada escenario  quitar los llamados a funciones
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

    method configurarPuertas(){} // implementar

    method colisiones(){
         game.onCollideDo(protagonista, {objeto => objeto.interaccion()})
    }

    method eventosIniciar(){}//sobreescribir metodo si hay eventos,usar los Tick

    method eventosFinalizar(){} // si hay eventos sobreescribir y remover los Tick

    method agregarVisualesEscena(){
        visualesEnEscena.forEach({v => game.addVisual(v)})
    } 

    method configurarConversacion(){} // solo sobreescribir si hay conversacion

    method limpiar(){
        game.removeVisual(fondo)
        self.limpiarVisualesEnEscena()
        ost.stop()
       // game.clear() // agregada,borrar si ya no sirve
        
    }
    method limpiarVisualesEnEscena(){
        visualesEnEscena.forEach({v=> game.removeVisual(v)})
    }

}




object fondo{
    /*
        INV. REP : La imagen tiene el tamaño del tablero 1300px(ancho) x 900px(alto)
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