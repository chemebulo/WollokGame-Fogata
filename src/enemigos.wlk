import wollok.game.*
import protagonista.*
import direccion.*
import estado.*
import elementos.*

class Lobo inherits Visual{
    // ############################################## ATRIBUTOS ############################################## //

    var property position = game.at(6,0)
    var property presa = protagonista
    var property vida = 3
    var property daño = 2
    var property image = "lobo-derecha.png"

    const property objetosConColision = #{amiga}

    // ########################################## MOVIMIENTO GENERAL ######################################### //

    method perseguirAPresaYAtacar(){
        self.validarSiEstaVivo()
        self.interaccionSiEstaSobreLaPresa()
        self.validarSiNecesitaMover()
        self.moverHaciaLaPresa()
    }

    method validarSiEstaVivo(){
        if (not self.estaVivo()) { self.error("Estoy muerto") }
    }

    method validarSiNecesitaMover(){
        if (self.estaSobrePresa()) { self.error("") }
    }

    method moverHaciaLaPresa(){
        if (self.estaEnElEjeYPuedeMoverAlEje(ejeX, ejeY)) { self.actualizarEnEje(ejeY) } else 
        if (self.estaEnElEjeYPuedeMoverAlEje(ejeY, ejeX)) { self.actualizarEnEje(ejeX) } else 
                                                          { self.actualizarEnEjeYEnEje(ejeY, ejeX) }
    }

    method actualizarEnEje(eje){
        const primeraDireccion = eje.primeraDir()
        const segundaDireccion = eje.segundaDir()

        if (self.tieneQueAumentarEnEje(eje)) { self.actualizarHacia(primeraDireccion) } else
                                             { self.actualizarHacia(segundaDireccion) }
    }

    method actualizarEnEjeYEnEje(primerEje, segundoEje){
        self.actualizarEnEje(primerEje)
        self.actualizarEnEje(segundoEje)
    }

    method actualizarHacia(direccion){
        position = direccion.siguientePosicion(position)
        self.cambiarImagen(direccion)
    }

    // ####################################### MOVIMIENTO - COLISIONES ####################################### // 

    method estaEnElEjeYPuedeMoverAlEje(primerEje, segundoEje) = primerEje.estaEnElMismoEjeQue(self, presa) and 
                                                                segundoEje.puedeMoverEnEje(self)
    
    method puedoMover(posicionAMover) = self.estaVivo() && not self.colisionoConAlgoEn(posicionAMover)

    method colisionoConAlgoEn(posicionAMover) = self.posicionesDeObjetosConColision().contains(posicionAMover)

    method posicionesDeObjetosConColision() = objetosConColision.map({cosa => cosa.position()})

    // ####################################### MOVIMIENTO - AUXILIARES ####################################### //

    method estaSobrePresa() = position == presa.position()

    method tieneQueAumentarEnEje(eje) = eje.tieneQueAumentarConRespectoA(self, presa)

    method cambiarImagen(direccion){ self.image("lobo-"+direccion.toString()+".png") } 

    method estaVivo() = self.vida() > 0

    // ############################################# INTERACCIÓN ############################################# // 
    
    method interaccionSiEstaSobreLaPresa() {
        if (self.estaSobrePresa() and presa.estaVivo()) { self.interaccion(presa) }
    }
    
    method interaccion(visual) {
        const vidaDespuesDelAtaque = visual.vida() - self.daño()
        
        visual.vida(vidaDespuesDelAtaque)
        game.say(visual, "¡Perdi 2 de vida!")
    }
}