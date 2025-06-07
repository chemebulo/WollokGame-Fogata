import protagonista.*
import direccion.*
import escenarios.*
import visualesDiapositivas.*
import visualesExtra.*

object videojuego{
    const gestorDiapositiva = diapositivasInicio
    const ostInicioJuego    = game.sound("inicio-v1.png")
    var property escenario  = inicioJuego
    var estoyEnPrologo      = true
   
    
    method iniciar(){ 
        ostInicioJuego.play()
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
    }

    // ############################## CONTROLES ##############################
    
    method controles(){
        keyboard.w().onPressDo({protagonista.mover(arriba)})
        keyboard.a().onPressDo({protagonista.mover(izquierda)})
        keyboard.s().onPressDo({protagonista.mover(abajo)})
        keyboard.d().onPressDo({protagonista.mover(derecha)})
        keyboard.e().onPressDo({protagonista.interactuarNPC()})
        keyboard.f().onPressDo({self.iniciarJuego()})
        keyboard.m().onPressDo({game.stop()})
        keyboard.y().onPressDo({self.juegoGanado()})
        keyboard.k().onPressDo({protagonista.atacar()})
    }

    // ################### INICIO DE JUEGO CON DIAPOSITIVAS ##################

    method iniciarJuego(){
        if(estoyEnPrologo){ 
            gestorDiapositiva.gestionarDiapositivas()
       }
    }

    method culminarPrologoEIniciarJuego(){
        /*
            PROPÓSITO: Borra las diapositivas en pantalla e inicia el juego.
                Este metodo solo se llama desde el gestor de diapositivas ya que  si lo agrego en 
                iniciarJuego() se ejecutara cada vez que presiono "f" y rompera todo el juego. 
                Debo pensar en un mejor diseño.
        */
        gestorDiapositiva.removerTodo()
        estoyEnPrologo = false // Evita que al pulsar "f" ejecute el gestor de diapositivas, una vez iniciado el juego.
        ostInicioJuego.stop()
        self.cambiarEscenario(escenarioInicial)
    }
}
        
// ###################################################### DIAPOSITIVAS DEL VIDEOJUEGO ######################################################
            

object diapositivasInicio{ // Podria ser una clase y usarse para distintos puntos del juego.
    const juego = videojuego

    const d0 = new Diapositiva(image = "diapo-1.png")
    const d1 = new Diapositiva(image = "diapo-2.png")
    const d2 = new Diapositiva(image = "diapo-3.png")
    const d3 = new Diapositiva(image = "diapo-4.png")
    const d4 = new Diapositiva(image = "diapo-5.png")
    const d5 = new Diapositiva(image = "diapo-6.png")
    const d6 = new Diapositiva(image = "diapo-7.png")
    const d7 = new Diapositiva(image = "diapo-8.png")
    const d8 = new Diapositiva(image = "diapo-9.png")
    const d9 = new Diapositiva(image = "diapo-10.png")

   const pelicula       = [d0, d1, d2, d3, d4, d5, d6, d7, d8, d9]
   const iteradorDiapos = new IteradorDiapositiva(listaAIterar = pelicula.copy())

    method gestionarDiapositivas(){
        if(iteradorDiapos.terminoPelicula()){
            juego.culminarPrologoEIniciarJuego()
        } else{
           iteradorDiapos.procesarDiapositivas()
        }
    }
           
    method ultimaDiapositiva() = pelicula.size() 
            
    method removerTodo(){
       pelicula.forEach({d => game.removeVisual(d)})
       pelicula.clear() // Deja vacía la lista para liberar recursos.
    }
}
        
class IteradorDiapositiva{
    /*
        Al dibujar una diapositiva, se dibuja el primer elemento de una lista y lo borra de la lista.
        Al pedir devuelta que dibuje una diapositiva, dibujaría el segundo, y así hasta que quede la lista vacia.
        El problema es cuando luego tengo que remover los visuales de cada diapositiva cuando termina la presentación,
        ya que se perdió la referencia de los visuales (quedó vacia la lista).
        Debido a este problema se crea la Clase Iterador de Diapositivas que funciona similar a los iteradores
        vistos en Estructuras de Datos (trabaja sobre una copia de la lista).
    */
    const listaAIterar 

    method procesarDiapositivas(){
        self.dibujarYActualizar(self.elementoAProcesar())
    }
        
    method dibujarYActualizar(elem){
        game.addVisual(elem)
        listaAIterar.remove(elem)
    }

    method terminoPelicula() = listaAIterar.isEmpty()

    method elementoAProcesar() = listaAIterar.first()
}