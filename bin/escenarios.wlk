import wollok.game.*
import protagonista.*
import videojuego.*

// depende la variable escenario de videojuego se mostrara un escenario u otro
object escenarioInicial{
    //muestra todo lo de el escenario
    method puestaEnEscena(){
        game.boardGround("fondo.png")

        game.addVisual(lobo)
        game.addVisual(amiga)
        game.addVisual(puerta)
        game.addVisual(protagonista)

        /* 
        SI EL PERSONAJE INTERACTUA CON LA PUERTA DEBERA CAMBIARSE DE ESCENARIO.
            DE MOMENTO NO ESTA RESUELTO Y LA PUERTA NO HACE NADA
            */
        game.onCollideDo(puerta, {videojuego.cambiarEscenario(escenario2)})
       
    }
    /* LA IDEA ES QUE AL CAMBIAR DE ESCENARIO, ANTES LIMPIE TODOS LOS OBJETOS. RESOLVER:*/
    method limpiar(){
        game.removeVisual(lobo)
        game.removeVisual(protagonista)
        game.removeVisual(amiga)

    }
}
/*de momento no se puede pasar al escenario 2*/
object escenario2{

   
    method puestaEnEscena(){

         game.boardGround("fondo2.png")
         protagonista.position(game.at(0,0))
         amiga.position(game.at(3,3))
         lobo.position(game.at(5,5))

         

         game.addVisual(lobo)
         game.addVisual(amiga)
         game.addVisual(protagonista)
    } 
    
    method limpiar(){
        game.removeVisual(lobo)
        game.removeVisual(protagonista)
        game.removeVisual(amiga)

        
    }
    

}