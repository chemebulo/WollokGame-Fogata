import src.gestorColisiones.*
import wollok.game.*
import protagonista.*
import direccion.*
import estado.*
import visualesExtra.*

class Lobo inherits Visual{
    // ############################################## ATRIBUTOS ############################################## //

    var property position   = game.at(6,0)
    var property image      = "lobo-derecha.png"
    var property vida       = 3
    const property presa    = protagonista
    const property daño     = 1
    const colisionesGestor  = gestorDeColisiones
    const direccionesGestor = gestorDeDirecciones
    const posicionesGestor  = gestorDePosiciones

    // ########################################## MOVIMIENTO GENERAL ######################################### //

    method perseguirAPresa() {
        if (self.estaSobrePresa() and self.estaVivo()) { self.atacarPresa() } else 
        if (self.estaVivo())                           { self.avanzarHaciaLaPresa() }
    }

    method avanzarHaciaLaPresa() {
        const positionAntigua = position
        self.avanzarSiPuede()
        self.cambiarImagen(direccionesGestor.direccionALaQueSeMovio(positionAntigua, position))
    }

    method avanzarSiPuede() {
        if(colisionesGestor.hayLindantesSinObstaculosSin(position, presa)) {position = self.siguientePosicion()}
    }
    
    method siguientePosicion() = posicionesGestor.lindanteConvenienteHacia(position, presa)

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

// ########################################################################################################### //

class LoboAgresivo inherits Lobo {
    override method atacarPresa() {
        game.schedule(1000, {presa.atacadoPor(self)})
    } 

    override method atacado(){
        game.say(self,"Estoy siendo atacado, auxilio")
    }
}

// ########################################################################################################### //

class LoboPasivo inherits Lobo {
    override method atacarPresa() {}

    override method interaccion() {}
}

// ########################################################################################################### //

const loboAgresivo = new LoboAgresivo()
const loboPasivo = new LoboPasivo()