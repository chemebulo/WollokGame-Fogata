import wollok.game.*
import protagonista.*
import videojuego.*
import puertas.*

// depende la variable escenario de videojuego se mostrara un escenario u otro
object escenarioInicial{
    //muestra todo lo de el escenario
    method puestaEnEscena(){
        game.boardGround("fondo.png")
        puertaAEscenarioSecundario.ubicarEn(game.at(6, 8))
        game.addVisual(lobo)
        game.addVisual(amiga)
        game.addVisual(puertaAEscenarioSecundario)
        game.addVisual(protagonista)

        /* SI EL PERSONAJE INTERACTUA CON LA PUERTA DEBERA CAMBIARSE DE ESCENARIO.
            DE MOMENTO NO ESTA RESUELTO Y LA PUERTA NO HACE NADA
            */
        game.onCollideDo(protagonista, {puertaAEscenarioSecundario => puertaAEscenarioSecundario.interaccion()})
       
    }
    /* LA IDEA ES QUE AL CAMBIAR DE ESCENARIO, ANTES LIMPIE TODOS LOS OBJETOS. RESOLVER:*/
    method limpiar(){
        game.removeVisual(lobo)
        game.removeVisual(protagonista)
        game.removeVisual(amiga)
        game.removeVisual(puertaAEscenarioSecundario)

    }
}
/*de momento no se puede pasar al escenario 2*/
object escenarioSecundario{

   
    method puestaEnEscena(){
         game.boardGround("fondo2.png")
         protagonista.position(game.at(0,0))
        //  amiga.position(game.at(3,3))
         lobo.position(game.at(5,5))
         puertaAEscenarioInicial.ubicarEn(game.at(6,0))
         puertaAEscenarioIzquierdo.ubicarEn(game.at(0,4))
         

         game.addVisual(lobo)
        // game.addVisual(amiga)
        // game.addVisual(puertaAEscenarioIzquierdo)
         game.addVisual(protagonista)
         game.addVisual(puertaAEscenarioInicial)
         game.onCollideDo(protagonista, {puertaAEscenarioInicial => puertaAEscenarioInicial.interaccion()})
        //game.onCollideDo(protagonista, {puertaAEscenarioIzquierdo => puertaAEscenarioIzquierdo.interaccion()})
    } 
    
    method limpiar(){
        game.removeVisual(lobo)
        game.removeVisual(protagonista)
        // game.removeVisual(amiga)
        game.removeVisual(puertaAEscenarioInicial)
    }

}

const puertaAEscenarioSecundario = new Puerta(image = "puerta.png", irHacia = escenarioSecundario)
const puertaAEscenarioInicial    = new Puerta(image = "puerta.png", irHacia = escenarioInicial)
const puertaAEscenarioIzquierdo  = new Puerta(image = "puerta.png", irHacia = escenarioInicial)
