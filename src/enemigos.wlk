import src.gestorColisiones.*
import wollok.game.*
import protagonista.*
import direccion.*
import estado.*
import visualesExtra.*

class Lobo inherits Visual{
    // ############################################## ATRIBUTOS ############################################## //

    var property position = game.at(6,0)
    var property image    = "lobo-derecha.png"
    var property vida     = 3
    const property presa  = protagonista
    const property daño   = 1

    // ########################################## MOVIMIENTO GENERAL ######################################### //

    method perseguirAPresa(){
        self.perseguirYAtacarPresa()
    }

    method perseguirYAtacarPresa(){
        if (not self.estaSobrePresa() and self.estaVivo()) { self.moverHaciaLaPresa() } else { self.atacarPresa() }
    }

    method moverHaciaLaPresa(){
        if (ejeX.mismoEjeEntreYPuedeMoverA(self, presa, ejeY)) { self.moverEnEje(ejeY) } else 
        if (ejeY.mismoEjeEntreYPuedeMoverA(self, presa, ejeX)) { self.moverEnEje(ejeX) } else 
                                                               { self.moverEnEjeYEnEje(ejeY, ejeX) }
    }

    method moverEnEje(eje){
        if (eje.necesitaAcercarseA(self, presa)) { self.moverHacia(eje.primeraDir()) } else
                                                 { self.moverHacia(eje.segundaDir()) }
    }

    method moverEnEjeYEnEje(primerEje, segundoEje){
        self.moverEnEje(primerEje)
        self.moverEnEje(segundoEje)
    }

    method moverHacia(direccion){
        position = direccion.siguientePosicion(position)
        self.cambiarImagen(direccion)
    }

    // ####################################### MOVIMIENTO - COLISIONES ####################################### // 

    override method esAtravesable() = false

    // ####################################### MOVIMIENTO - AUXILIARES ####################################### //

    method estaSobrePresa() = position == presa.position()

    method cambiarImagen(direccion){ self.image("lobo-"+direccion.toString()+".png") } 

    method estaVivo() = self.vida() > 0

    // ############################################# INTERACCIÓN ############################################# // 
    
    method interaccion() {}

    method atacarPresa()
}

object loboAgresivo inherits Lobo {
    override method atacarPresa() {
        game.schedule(1000, {presa.atacadoPor(self)})
    } 
}


object loboPasivo inherits Lobo {

    override method atacarPresa() {}


    override method interaccion() {}
}



