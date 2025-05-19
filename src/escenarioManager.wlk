import wollok.game.*
import protagonista.*
import elementos.*

//##############ELEMENTOS PARA CONSTRUIR EL MAPA #############
class Elemento{
    method construir(posicion){}
}


object _ inherits Elemento{
}
object z inherits Elemento{ // protagonista
    override method construir(posicion){
        protagonista.position(posicion)
    }
}


   
    
object f inherits Elemento{ //fogata

    override method construir(posicion){
        fogata.position(posicion)
    }
}

object c inherits Elemento{ //carpa
    override method construir(posicion){
        carpa.position(posicion)
    }
}

object l inherits Elemento{ //lobo IMPLEMENTAR!!
    override method construir(posicion){
        
    }
}

object g inherits Elemento{ // guardabosques.No implementado, no usar
    override method construir(posicion){}
}

// ###################### NIVEL #########################



class Escenario{ // cada escenario del archivo escenario.wlk heredara de esta clase
        /*
            "Como implementar por cada escenario":
                * fondoEscenario, esta variable sera el fondo del escenario, tiene que tener las medidas del tablero
                * tablero() devuelve la matriz que se va a dibujar con las medidas del tablero
                *puestaEnEscena:
                    *configurar el estado actual del protagonista
                    *settear la ubicacion de las puertas (deben ir a los escenarios siguientes o lanzar mensaje de que no se puede volver)
                    *configurar si hay interaccion con los npc
                    *configurar los oncollide,when Collide o colisiones con enemigos y puertas 
                    *agregar eventos y configurarlos si lo hubiera
                    *dibujarTablero() a partir del llamado a tablero() dibuja el tablero. Véase ejemplo en escenarioInicial


                * limpiar() remueve todos los visuales para el proximo escenario.este metodo solo se llama cuando se interactua con las puertas
        */

    const  fondoEscenario // la imagen que va a ser de fondo del escenarop: debe tener el tamaño del tablero
    const mapa
    // se dibuja a el tablero como la matriz: const mapa : [...].reverse(), véase ejemplo en escenarioInicial
                     
    

    method puestaEnEscena(){
        
        fondo.visualizarFondo(fondoEscenario)
        self.configurarConversacion()
        /*
        ... todas las configuraciones 
        */
        // se llama dibujarTablero()
        self.dibujarTablero()
        self.agregarVisualesEscena()
        self.colisiones()
        
    }  

    method dibujarTablero() {
         (0 .. game.width() - 1).forEach({x =>  
            (0 .. game.height() - 1).forEach( {y => 
                const constructor = mapa.get(y).get(x)
                constructor.construir(game.at(x, y))
            })
        })
    }

    method colisiones(){
         game.onCollideDo(protagonista, {objeto => objeto.interacion()})
    }

    method eventos(){}//sobreescribir metodo si hay eventos

    method agregarVisualesEscena() 
    // en agregar VisualesEscena se agregan todos los visuales, el protagonista debe quedar ultimo,testear como quedan los lobos en escena

    method configurarConversacion(){} // solo sobreescribir si hay conversacion

    method limpiar(){
        game.clear()
        //si hay ticket de evento sobreescribir, usar super() y agregar removeTick
    }

}




object fondo{
    /*
        INV. REP : La imagen tiene el tamaño del tablero
    */
    var property position = game.at(0,0)
    var property image = ""

    
    method visualizarFondo(fondoEscenario){
        image = fondoEscenario
        game.addVisual(self)    
    }
}