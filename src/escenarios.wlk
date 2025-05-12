


import wollok.game.*
import protagonista.*
import videojuego.*
import enemigos.*
import puertas.*
import direccion.*

object escenarioInicial{


    const pj = protagonista
    const puertaNorte = new PuertaAbierta (image = "puerta.png", position = norte, irHacia = escenarioBifurcacion)

    const visualesEnEscena = [amiga,fogata,carpa, puertaNorte]

    const noColisionar =#{amiga,fogata,carpa} // el personaje no atraviesa estos objetos

    method puestaEnEscena(){
        self.configurarProtagonista(noColisionar) // actualiza las posiciones de  los objetos que no se pueden colisionar
        self.agregarVisuales()

        game.onCollideDo(pj, {objeto => objeto.interacion()})
        /*
            game.onTick...en caso de que hagan falta eventos
        */
    }
    
    method configurarProtagonista(objetos){
        pj.objetosColision(objetos)
    }
    /*
        se necesita un metodo que configure la ubicacion de todos los visuales
    */

    method agregarVisuales(){
        visualesEnEscena.forEach({visual => game.addVisual(visual)})
        game.addVisualCharacter(protagonista)
    }

    method limpiar(){
        visualesEnEscena.forEach({visual => game.removeVisual(visual)})
        game.removeVisual(pj)

        /*
            game.removeTickEvent(event)..en caso de que haya eventos en los escenarios
        */
    }
    
}
object escenarioBifurcacion{}
object escenarioGalpon{}
object escenarioEntrarACabaña{}


