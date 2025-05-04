import wollok.game.*
import protagonista.*
import videojuego.*


object escenarioInicial{
    method puestaEnEscena(){
        game.boardGround("fondo.png")

        game.addVisual(lobo)
        game.addVisual(amiga)
        game.addVisual(puerta)
        game.addVisual(protagonista)

        game.onCollideDo(puerta, {videojuego.cambiarEscenario(escenario2)})
       
    }

    method limpiar(){
        game.removeVisual(lobo)
        game.removeVisual(protagonista)
        game.removeVisual(amiga)

    }
}

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