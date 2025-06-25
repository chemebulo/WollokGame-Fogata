import videojuego.*
import escenariosManager.*

object gestorDeDiapositivas{ // Objeto que usa videojuego para gestion de diapositivas
    var property peliculaAMostrar    = peliculaInicioJuego
    var property bloqueAEjecutar     = inicioJuegoD
    const juego                      = videojuego
    var property esHoraDeDiapositiva = true

    method gestionarDiapositivas(){
        if(self.esLaUltimaDiapositiva()){
            juego.culminarDiapositivasYContinuar(self.bloqueAEjecutar())
        } else {
           self.diapositivaActual().procesarDiapositiva()
        }
    } 

    method diapositivaActual(){
        return peliculaAMostrar.iteradorActual()
    }
    
    method esLaUltimaDiapositiva(){
        return peliculaAMostrar.iteradorActual().terminoPelicula()
    }

    method ultimaDiapositiva(){
        return peliculaAMostrar.peliculaActual().size()
    }
           
    method removerTodo(){
        //  Deja vacía la lista para liberar recursos
       peliculaAMostrar.liberarMemoria() 
       peliculaAMostrar = null
    }

    method esTiempoDeDiapositiva(){
        return esHoraDeDiapositiva
    }

     method interactuarDiapositivas(){
        if(esHoraDeDiapositiva){ 
            self.gestionarDiapositivas()
        }
    }

    method configurarParaSiguiente(nuevaPelicula,nuevoBloque){
        self.esHoraDeDiapositiva(false)
        self.peliculaAMostrar(nuevaPelicula)
        self.bloqueAEjecutar(nuevoBloque)
    }
}

/*
    BLOQUES QUE EJECUTAN LO QUE SUCEDE AL FINALIZAR LA ULTIMA DIAPOSITIVA DE LA ESCENA EN UN ESCENARIO
    v=videojuego
    g=gestorDeDiapositivas
*/
const inicioJuegoD = {v,g => g.removerTodo();
                             g.configurarParaSiguiente(peliculaAmigaMuerta, despuesDeAmigaMuerta)                      
                             v.cambiarEscenario(fogata)}
   
const despuesDeAmigaMuerta = {v,g => g.removerTodo();
                                     g.configurarParaSiguiente(peliculaGranero, despuesDeGranero)                               
                                     bifurcacion.configuradorTotal(bifurcacionC_v4, bifurcacionCES_v4)                       
                                     v.cambiarEscenario(bifurcacion)}                                         

const despuesDeGranero = {v,g => g.removerTodo(); 
                                 g.configurarParaSiguiente(peliculaPeleaFinal, despuesDePeleaFinal)
                                 v.cambiarEscenario(granero)}        

const despuesDePeleaFinal = {v,g => g.removerTodo(); 
                                    g.configurarParaSiguiente(finalJuego, despuesFinalJuego)                              
                                    v.cambiarEscenario(peleaFinal)}      

const despuesFinalJuego = {} // COMPLETAR                                              

// LAS PELICULAS QUE SE MUESTRAN
const peliculaInicioJuego = new Pelicula(pelicula = [d0, d1, d2, d3, d4, d5, d6, d7, d8, d9])
const peliculaGranero     = new Pelicula(pelicula = [dg0, dg1, dg2])
const peliculaAmigaMuerta = new Pelicula(pelicula = [dam1, dam2, dam3])
const peliculaPeleaFinal  = new Pelicula(pelicula = [dpf1, dpf2, dpf3])
const finalJuego          = new Pelicula(pelicula = []) // completar

class Pelicula{
    const pelicula
    const iteradorPelicula = new IteradorDiapositiva(listaAIterar = self.peliculaActual().copy())

    method peliculaActual(){
        return pelicula
    }

    method iteradorActual(){
        return iteradorPelicula
    }

    method liberarMemoria(){
        pelicula.forEach({d => d.borrar()})
        pelicula.clear()
    }
}

// DIAPOSITIVAS PARA TODO EL JUEGO                                        
const dpf1 = new Diapositiva(image ="diapo-pelea-final2.png")
const dpf2 = new Diapositiva(image ="diapo-pelea-final3.png")
const dpf3 = new Diapositiva(image ="diapo-pelea-final4.png")

const dam1 = new Diapositiva(image ="diapo-amiga-muerta2.png")
const dam2 = new Diapositiva(image ="diapo-amiga-muerta3.png")
const dam3 = new Diapositiva(image ="diapo-amiga-muerta4.png")

const d0  = new Diapositiva(image = "diapo-1.png")
const d1  = new Diapositiva(image = "diapo-2.png")
const d2  = new Diapositiva(image = "diapo-3.png")
const d3  = new Diapositiva(image = "diapo-4.png")
const d4  = new Diapositiva(image = "diapo-5.png")
const d5  = new Diapositiva(image = "diapo-6.png")
const d6  = new Diapositiva(image = "diapo-7.png")
const d7  = new Diapositiva(image = "diapo-8.png")
const d8  = new Diapositiva(image = "diapo-9.png")
const d9  = new Diapositiva(image = "diapo-10.png")
const dg0 = new Diapositiva(image = "diapo-granero-2.png")
const dg1 = new Diapositiva(image = "diapo-granero-3.png")
const dg2 = new Diapositiva(image = "diapo-granero-4.png")
    
//####################################

class IteradorDiapositiva{
    /*
        Al dibujar una diapositiva, se dibuja el primer elemento de una lista y lo borra de la lista.
        Al pedir devuelta que dibuje una diapositiva, dibujaría el segundo, y así hasta que quede la lista vacia.
        El problema es cuando luego tengo que remover los visuales de cada diapositiva cuando termina la presentación,
        como borre todas se perdió la referencia de los visuales (quedó vacia la lista).
        Debido a este problema se crea la Clase Iterador de Diapositivas que trabaja sobre una copia de las diapositivas
        para mostrarlas. Luego cuando se borran se hace desde la lsita original
    */
    const listaAIterar

    method procesarDiapositiva(){
        self.dibujarYActualizar(self.elementoAProcesar())
    }
        
    method dibujarYActualizar(elem){
        game.addVisual(elem)
        listaAIterar.remove(elem)
    }

    method terminoPelicula(){
        return listaAIterar.isEmpty()
    }

    method elementoAProcesar(){
        return listaAIterar.first()
    }
}

class Diapositiva{
    var property position = game.at(0,0)
    var property image 
    
    method esAtravesable(){
        return true
    }
    
    method borrar(){
        return game.removeVisual(self)
    }

    method atacadoPor(visual){}
}