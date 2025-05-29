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
    const property daño   = 2

    // ########################################## MOVIMIENTO GENERAL ######################################### //

    method perseguirAPresa(){
        self.validarSiEstaVivo()
        self.moverSiEsNecesario()
    }

    method validarSiEstaVivo(){
        if (not self.estaVivo())   { self.error("Estoy muerto") }
    }

    method moverSiEsNecesario(){
        if (not self.estaSobrePresa()) { self.moverHaciaLaPresa() }
    }

    method moverHaciaLaPresa(){
        if (self.estaEnElEjeYPuedeMoverAlEje(ejeX, ejeY)) { self.moverEnEje(ejeY) } else 
        if (self.estaEnElEjeYPuedeMoverAlEje(ejeY, ejeX)) { self.moverEnEje(ejeX) } else 
                                                          { self.moverEnEjeYEnEje(ejeY, ejeX) }
    }

    method moverEnEje(eje){
        const primeraDireccion = eje.primeraDir()
        const segundaDireccion = eje.segundaDir()

        if (self.tieneQueAumentarEnEje(eje)) { self.moverHacia(primeraDireccion) } else
                                             { self.moverHacia(segundaDireccion) }
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

    method puedoMover(posicionAMover) {
        return self.estaVivo() && not self.hayObstaculos(posicionAMover)
    }
    
    method hayObstaculos(posicion) {
        return not self.objetosEnPosicion(posicion).all({visual => visual.esAtravesable()})
    }

    method objetosEnPosicion(posicion){
        return game.getObjectsIn(posicion).copyWithout(presa)
    }

    // ####################################### MOVIMIENTO - AUXILIARES ####################################### //

    method estaEnElEjeYPuedeMoverAlEje(primerEje, segundoEje) = primerEje.estaEnElMismoEjeQue(self, presa) and 
                                                                segundoEje.puedeMoverEnEje(self)

    method estaSobrePresa() = position == presa.position()

    method tieneQueAumentarEnEje(eje) = eje.tieneQueAumentarConRespectoA(self, presa)

    method cambiarImagen(direccion){self.image("lobo-"+direccion.toString()+".png")} 

    method estaVivo() = self.vida() > 0

    // ############################################# INTERACCIÓN ############################################# // 
    
    method interaccion() {
        self.validarPresa()
        self.atacarPresa()
    }

    method validarPresa() {
        if(not presa.estaVivo()){
            self.error("Estoy muerto")
        }
    }

    method atacarPresa() {
        presa.vida(presa.vida() - self.daño())
        game.say(presa, "¡Perdi 2 de vida!")
    }
}

object loboAgresivo inherits Lobo {
}

object loboPasivo inherits Lobo {
    override method interaccion() {}
}


