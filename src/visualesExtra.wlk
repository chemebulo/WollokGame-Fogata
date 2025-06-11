import protagonista.*
import escenarios.*
import confgEscSig.*
import confgEscenarios.*
import npcEstados.*

class Visual{
    method esAtravesable(){
        return false
    }

    method atacadoPor(visual){}
}

// ####################################################################################################### //

class VisualConMovimiento inherits Visual{
    var property position // Describe la posición actual del visual.
    var property vida
    var property image  = null
    const property daño = 1

    // ============================================================================================================= \\

    method cambiarImagen(direccion){
        // Cambia la imagen del lobo dependiendo de la dirección dada. 
        self.image(self.imagenNueva(direccion))
    }

    // ============================================================================================================= \\

    method imagenNueva(direccion) // Describe la imagen nueva del visual en base a la dirección dada.

    // ============================================================================================================= \\

    method interaccion(){} // Representa la interacción del visual con los diferentes objetos, en este caso no tiene ninguna.

    // ============================================================================================================= \\

    method estaVivo(){
        // Indica si el enemigo se encuentra vivo o no.
        return self.vida() > 0
    }

    // ============================================================================================================= \\

    method actualizarAMuerto(){
        vida = 0
    }
}


// ####################################################################################################### //

object amiga inherits Visual{
    var property dialogo = []

    method image() = "amiga.png"

    var property position = game.at(2,4)
}

// ####################################################################################################### //

object fogata inherits Visual{
    method image() = "fogata-apagada.png"

    var property position = game.at(3,4)
}

// ####################################################################################################### //

object carpa inherits Visual{
    var property image = "carpa.png"

    var property position = game.at(6,4)
}

// ####################################################################################################### //

object leña inherits Visual{
    method image() = "leña.png"

    var property position = game.at(5,6)

    override method esAtravesable() = true

    method interaccion() {
        game.removeVisual(self)
        game.addVisual(puertaEntradaCabaña)
        puertaEntradaCabaña.irHacia(escenarioEntradaCabaña)
        game.say(protagonista,"Gracias por la leña señor")
        escenarioEntradaCabaña.confgEscSiguiente(confg_escSig_escenarioEntradaCabaña_v2);
        escenarioEntradaCabaña.confgActual(confg_escenarioEntradaCabaña_v2)
    }
}

// ####################################################################################################### //

object cabaña inherits Visual{
    method image() = "cabaña_entrada.png"

    var property position = game.at(5,6)

    override method esAtravesable() = true

    method interaccion(){}
}

// ####################################################################################################### //

object hacha inherits Visual{
    method image() = "hacha.png"

    var property position = game.at(5,5)

    override method esAtravesable() = true 

    method interaccion(){
        game.removeVisual(self)
        protagonista.estadoCombate(armadoProtagonista)
        game.say(protagonista,"Ya puedo defenderme")
    }
}

// ####################################################################################################### //

class Obstaculo inherits Visual{
    method image() = "obstaculo.png"

    var property position
}

// ####################################################################################################### //


object gameover{
    method image() = "game-over.png"

    method position() = game.at(0,0)
}

// ####################################################################################################### //

object juegoGanado{
    method image() = "game-win.png"

    method position() = game.at(0,0)
}