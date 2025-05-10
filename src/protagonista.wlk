import wollok.game.*
import direccion.*
import enemigos.*
import estado.*

object protagonista{
    // ############################################## ATRIBUTOS ############################################## //

    var property position = game.at(6,4)
    var property vida = 10
    var property daño = 1
    var property image = "protagonista-abajo.png"
 
    const property objetosConColision = #{amiga}

   // ########################################## MOVIMIENTO GENERAL ######################################### //

    method mover(direccion){
        self.validarSiEstaVivo()
        self.validarSiPuedeMover(direccion)
        self.moverAl(direccion)
    }

    method validarSiEstaVivo(){
        if (not self.estaVivo()) { self.error("Estoy muerto") }
    }

    method validarSiPuedeMover(direccion){ 
        const posicionAMover = direccion.siguientePosicion(position)

        if(not self.puedoMover(posicionAMover)){ self.error("No puedo atravesar objetos o salir del mapa") }
    }

    method moverAl(direccion){
        position = direccion.siguientePosicion(position)
        self.cambiarImagen(direccion)
    }

    // ####################################### MOVIMIENTO - COLISIONES ####################################### // 
    
    method puedoMover(posicionAMover) = self.estaDentroDelTablero(posicionAMover) and
                                        not self.colisionoConAlgoEn(posicionAMover)

    method estaDentroDelTablero(posicionAMover) = posicionAMover.x().between(0, game.width()  - 1) and 
                                                  posicionAMover.y().between(0, game.height() - 1) 
    
    method colisionoConAlgoEn(posicionAMover) = self.posicionesDeObjetosConColision().contains(posicionAMover)

    method posicionesDeObjetosConColision() = objetosConColision.map({cosa => cosa.position()})
    
    method cambiarImagen(direccion){ self.image( "protagonista-"+direccion.toString()+".png") }

    method estaVivo() = self.vida() > 0

    // ############################################# INTERACCIÓN ############################################# // 

    method interaccion(visual) {
        // Por ahora nada...
    }
}

object celda{
    method estaVacia(position) = game.getObjectsIn(position).isEmpty()
}

object amiga{
    var property position = game.at(1,4)

    method image() = "amiga.png"
}