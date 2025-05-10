import wollok.game.*
import protagonista.*
import videojuego.*
import enemigos.*
import puertas.*

object escenarioInicial{}
object escenarioBifurcacion{}
object escenarioGalpon{}
object escenarioEntrarACabaña{}
/*
object escenarioInicial{
    const lobo1 = new Lobo()

    method puestaEnEscena(){
        game.boardGround("fondo.png")
        puertaAEscenarioSecundario.ubicarEn(game.at(6, 8))
        game.addVisual(lobo1)
        game.onTick(800, "Movimiento del Lobo", { lobo1.perseguirAPresaYAtacar() })
        game.addVisual(amiga)
        game.addVisual(puertaAEscenarioSecundario)
        game.addVisual(protagonista)

        game.onCollideDo(protagonista, {puertaAEscenarioSecundario => puertaAEscenarioSecundario.interaccion()})
    }

    method limpiar(){
        game.removeVisual(lobo1)
        game.removeVisual(protagonista)
        game.removeVisual(amiga)
        game.removeVisual(puertaAEscenarioSecundario)
    }
}

object escenario2{
    const lobo1 = new Lobo()
   
    method puestaEnEscena(){
         game.boardGround("fondo2.png")
         protagonista.position(game.at(0,0))
         amiga.position(game.at(3,3))

         game.addVisual(amiga)
        //  amiga.position(game.at(3,3))
         lobo1.position(game.at(5,5))
         puertaAEscenarioInicial.ubicarEn(game.at(6,0))
         puertaAEscenarioIzquierdo.ubicarEn(game.at(0,4))
         

         game.addVisual(lobo1)
        // game.addVisual(amiga)
        // game.addVisual(puertaAEscenarioIzquierdo)
         game.addVisual(protagonista)
         game.addVisual(puertaAEscenarioInicial)
         game.onCollideDo(protagonista, {puertaAEscenarioInicial => puertaAEscenarioInicial.interaccion()})
        //game.onCollideDo(protagonista, {puertaAEscenarioIzquierdo => puertaAEscenarioIzquierdo.interaccion()})
    } 
    
    method limpiar(){
        game.removeVisual(protagonista)
        game.removeVisual(amiga)
        game.removeVisual(puertaAEscenarioInicial)
    }
}

const puertaAEscenarioSecundario = new Puerta(image = "puerta.png", irHacia = escenarioSecundario)
const puertaAEscenarioInicial    = new Puerta(image = "puerta.png", irHacia = escenarioInicial)
const puertaAEscenarioIzquierdo  = new Puerta(image = "puerta.png", irHacia = escenarioInicial)
*/