import videojuego.*
import escenarios.*
object gestorDeDiapositivas{ // Objeto que usa videojuego para gestion de diapositivas
    const juego = videojuego
  

    var property peliculaAMostrar = peliculaInicioJuego

   var property bloqueAEjecutar = inicioJuegoD

    
    method gestionarDiapositivas(){
        if(peliculaAMostrar.iteradorActual().terminoPelicula()){
            
            juego.culminarDiapositivasYContinuar(self.bloqueAEjecutar())
        } else{
           peliculaAMostrar.iteradorActual().procesarDiapositivas()
        }
    }
    method ultimaDiapositiva() = peliculaAMostrar.peliculaActual().size() 
           
    method removerTodo(){
       peliculaAMostrar.peliculaActual().forEach({d => game.removeVisual(d)})
       peliculaAMostrar.peliculaActual().clear() // Deja vacía la lista para liberar recursos.
       peliculaAMostrar = null
    }
            
}
/*
    BLOQUES QUE EJECUTAN LO QUE SUCEDE AL FINALIZAR LA ULTIMA DIAPOSITIVA DE LA ESCENA
*/
const inicioJuegoD = {v => gestorDeDiapositivas.removerTodo();
                        v.estoyEnPrologo( false );
                      
                        gestorDeDiapositivas.peliculaAMostrar(peliculaGranero)
                        gestorDeDiapositivas.bloqueAEjecutar(despuesDeGranero)
                        v.cambiarEscenario(escenarioInicial) ;

}    
const despuesDeGranero = {v => gestorDeDiapositivas.removerTodo(); // SI SE AGREGAN MAS DIAPOSITIVAS SETTEAR AQUI
                         v.estoyEnGranero( false );
                        
                         v.cambiarEscenario(escenarioTEST) ;            

}        


/*
    DIAPOSITIVAS
*/
class Pelicula{
    method peliculaActual() 
    method iteradorActual()
}

object peliculaInicioJuego inherits Pelicula{

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

    const pelicula=  [d0, d1, d2, d3, d4, d5, d6, d7, d8, d9]
    const iteradorPelicula = new IteradorDiapositiva(listaAIterar = self.peliculaActual().copy())

   override  method peliculaActual() =  pelicula

    override method iteradorActual() = iteradorPelicula
}

object peliculaGranero inherits Pelicula{
    const dg0 = new Diapositiva(image = "granero-diapo2.png")
    const dg1 = new Diapositiva(image = "granero-diapo3.png")
    const dg2 = new Diapositiva(image = "granero-diapo4.png")

   
    const pelicula =  [dg0,dg1,dg2]
    const iteradorPelicula = new IteradorDiapositiva(listaAIterar = self.peliculaActual().copy())

    override method peliculaActual() = pelicula

    override method iteradorActual() = iteradorPelicula

}

//####################################

class IteradorDiapositiva{
    /*
        Al dibujar una diapositiva, se dibuja el primer elemento de una lista y lo borra de la lista.
        Al pedir devuelta que dibuje una diapositiva, dibujaría el segundo, y así hasta que quede la lista vacia.
        El problema es cuando luego tengo que remover los visuales de cada diapositiva cuando termina la presentación,
        ya que se perdió la referencia de los visuales (quedó vacia la lista).
        Debido a este problema se crea la Clase Iterador de Diapositivas que trabaja sobre una copoa de las diapositivas
        .
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
class Diapositiva{
    var property position = game.at(0,0)
    var property image 
    
   method esAtravesable() = true 

   method interaccion() = game.removeVisual(self)
}