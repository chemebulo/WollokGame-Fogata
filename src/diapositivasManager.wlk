import videojuego.*
import escenariosManager.*

object gestorDeDiapositivas{ 

    var property peliculaAMostrar    = peliculaInicioJuego
    var property bloqueAEjecutar     = inicioJuegoD
    const juego                      = videojuego
    var property esHoraDeDiapositiva = true

     method interactuarDiapositivas(){
        if(esHoraDeDiapositiva){ 
            self.gestionarDiapositivas()
        }
    }

    method gestionarDiapositivas(){
        if(peliculaAMostrar.esLaUltimaDiapositiva()){
            peliculaAMostrar.borrarDiapositivasDelTablero()
            juego.culminarDiapositivasYContinuar(self.bloqueAEjecutar())
        } else {
            peliculaAMostrar.procesarDiapositiva()
        }
    } 
   
    method configurarParaSiguiente(nuevaPelicula,nuevoBloque){
        self.esHoraDeDiapositiva(false)
        self.peliculaAMostrar(nuevaPelicula)
        self.bloqueAEjecutar(nuevoBloque)
    }

    method configuracionFinal(){
        self.esHoraDeDiapositiva(false)
        peliculaAMostrar = null
    }
}

/*
    BLOQUES QUE EJECUTAN LO QUE SUCEDE AL FINALIZAR LA ULTIMA DIAPOSITIVA DE LA ESCENA EN UN ESCENARIO
    v=videojuego
    g=gestorDeDiapositivas
*/
const inicioJuegoD = {v,g => g.configurarParaSiguiente(peliculaAmigaMuerta, despuesDeAmigaMuerta)                      
                             v.cambiarEscenario(fogata)}
   
const despuesDeAmigaMuerta = {v,g => g.configurarParaSiguiente(peliculaGranero, despuesDeGranero)                               
                                     bifurcacion.configuradorTotal(bifurcacionC_v4, bifurcacionCES_v4)                       
                                     v.cambiarEscenario(bifurcacion)}                                         

const despuesDeGranero = {v,g => g.configurarParaSiguiente(peliculaPeleaFinal, despuesDePeleaFinal)
                                 v.cambiarEscenario(granero)}        

const despuesDePeleaFinal = {v,g => g.configuracionFinal()                          
                                    v.cambiarEscenario(peleaFinal)}      

                                          
/*#############################################################################
                               PELICULAS
##############################################################################*/

class Pelicula{
    /*
        @param pelicula = una lista de diapositivas.Requerida para luego remover los visuales de diapositivas
        @iteradorPelicula = un Iterador que recibe una @pelicula. Muestra las diapositivas funcionando 
        como una cola y al terminar queda vacia. 

    */
    const pelicula
   const iteradorPelicula = pelicula.copy()

    method esLaUltimaDiapositiva(){
       return iteradorPelicula.isEmpty()
    }

    method procesarDiapositiva(){

       self.dibujarYActualizar(self.diapositivaActual())
    }

     method diapositivaActual(){
        return iteradorPelicula.first()
    }

     method dibujarYActualizar(elem){
        game.addVisual(elem)
        iteradorPelicula.remove(elem)
    }


    method borrarDiapositivasDelTablero(){
        pelicula.forEach({d => d.borrar()})
        pelicula.clear()
    }
}


const peliculaInicioJuego = new Pelicula(pelicula = [d0, d1, d2, d3, d4, d5, d6, d7, d8, d9])
const peliculaGranero     = new Pelicula(pelicula = [dg0, dg1, dg2])
const peliculaAmigaMuerta = new Pelicula(pelicula = [dam1, dam2, dam3])
const peliculaPeleaFinal  = new Pelicula(pelicula = [dpf1, dpf2, dpf3])

/*#############################################################################
                            DIAPOSITIVAS
##############################################################################*/

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