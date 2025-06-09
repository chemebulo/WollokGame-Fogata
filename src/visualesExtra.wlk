import protagonista.*
import escenarios.*
import confgEscSig.*
import confgEscenarios.*
import npcEstados.*

class Visual{
    method esAtravesable(){
        return false
    }

    method atacado(){}
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
        protagonista.estadoProta(armadoProtagonista)
        game.say(protagonista,"Ya puedo defenderme")
    }
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