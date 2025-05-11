


import wollok.game.*
import protagonista.*
import videojuego.*

// depende la variable escenario de videojuego se mostrara un escenario u otro
object escenarioInicial{

    const visualesEscena = [lobo,amiga,puerta,protagonista]
    const puertaActual = puerta

    const puertaArriba    = new PuertaCerrada   (ubicacion = arriba)
    const puertaIzquierda = new PuertaCerrada   (ubicacion = izquierda)
    const puertaDerecha   = new Puerta          (ubicacion = abajo)
    const puertaAbajo     = new Puerta          (ubicacion = derecha) 

  
    
    


    //muestra todo lo de el escenario
    method puestaEnEscena(){

        
        game.boardGround("fondo.png")

        self.añadirVisuales()
       

        /* 
        SI EL PERSONAJE INTERACTUA CON LA PUERTA DEBERA CAMBIARSE DE ESCENARIO.
            DE MOMENTO NO ESTA RESUELTO Y LA PUERTA NO HACE NADA
            */
        game.onCollide(puertaArriba,{puertaArriba => puertaArriba.mensaje("Debo ir a la cabaña")})

        game.onCollideDo(puertaIzquierda,{puertaIzquierda.mensaje("Debo ir a la cabaña")})

        game.onCollideDo(puertaDerecha,{puertaDerecha => puertaDerecha.irAEscenario(escenario2)})

        game.onCollideDo(puertaAbajo,{puertaAbajo => puertaAbajo.volverA(escenarioInicial)})
   
       
    }
    method añadirVisuales(){
        visualesEscena.forEach({elem => game.addVisual(elem)})
    }
    method limpiar(){
        visualesEscena.forEach({elem => game.removeVisual(elem)})
    }
    //method puerta()= puertaActual
    /* LA IDEA ES QUE AL CAMBIAR DE ESCENARIO, ANTES LIMPIE TODOS LOS OBJETOS. RESOLVER:*/
    /*method limpiar(){
        game.removeVisual(lobo)
        game.removeVisual(protagonista)
        game.removeVisual(amiga)

    }*/
    
         
}
//cambios
/*de momento no se puede pasar al escenario 2*/
object escenario2{

   
    method puestaEnEscena(){

         game.boardGround("fondo2.png")
         
         puerta.position(game.at(5,0))
         protagonista.position(game.at(5,3))
         amiga.position(game.at(3,3))
         lobo.position(game.at(0,5))

         
        game.addVisual(puerta)
         game.addVisual(lobo)
         game.addVisual(amiga)
         game.addVisualCharacter(protagonista)

         
    }
    method limpiar(){}
    /*
    method limpiar(){
        game.removeVisual(lobo)
        game.removeVisual(protagonista)
        game.removeVisual(amiga)

        
    }
    */
    

}