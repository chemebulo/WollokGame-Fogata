import escenarios.*
import wollok.game.*
import direccion.*

object protagonista{

    var property position = game.at(7,7)
    var image = "prota-100.png"
 
    const property objetosColision = #{amiga} //set de cosas que el prota no puede atravesar

    //const property objetosParaInteractuar = #{puerta} de momento se descarta

    method image()= image

    method image(_image){image=_image}

    

   //--------------MOVIMIENTO-------------------
    method mover(direccion){
        
        self.validarMover(direccion)
        self.cambiarImagen(direccion)
        position = direccion.siguientePosicion(position)
        
        
    }
    method validarMover(direccion){ 
        const posicionAMover = direccion.siguientePosicion(position)

        if(not self.puedoMover(posicionAMover)){ 
            self.error("No puedo atravesar objetos o salir del mapa")
        }
    }

    method puedoMover(posicionAMover){
        /*
            *Verifica si la posicion a la que quiero mover sigue dentro del tablero 
            o si en esa posicion hay un objeto que no puedo atravesar
        */
        return 
             (self.posSigueEnTablero(posicionAMover))  and 
              not self.colisionareConAlgo(posicionAMover)
    }
    //--- -----verificacion si sale del tablero si se mueve a la posicion dada-----------


     method posSigueEnTablero(posicionAMover){
        return posicionAMover.x().between(0, game.width() - 1) and 
                    posicionAMover.y().between(0, game.height() - 1) 
    } 
    //-----------verifico si colisionare con algo---------

    method colisionareConAlgo(posicionAMover){
         
        const colisiones = self.posicionesColision()
        return colisiones.contains(posicionAMover)
    }

   method posicionesColision(){
       return objetosColision.map({cosa => cosa.position()})
   }
    
  
  

  method cambiarImagen(direccion){
    self.image( "prota-"+direccion.toString()+".png")
  }
  

}



object puerta{

    var property position = game.at(6,8)

    method image() = "puerta.png"

    
    
      

    
}

object puerta2{
    var property position = game.at(5,3)

    method image() = "puerta2.png"
}

object celda{
    method estaVacia(position) = game.getObjectsIn(position).isEmpty()
}





object amiga{
    var property position = game.at(1,4)

    method image() = "amiga.png"
}

class Lobos {}
object lobo inherits Lobos {
    var property position = game.at(1,2)

    method image() = "lobo.png"
}