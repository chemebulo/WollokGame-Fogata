import protagonista.*
import escenarios.*

class Visual{
    method esAtravesable(){
        return false
    }
}

// ###########################################################

object amiga inherits Visual{
    var property dialogo = []

    method image() = "amiga.png"

    var property position = game.at(2,4)

   

    method xPos() = self.position().x()

   
}

// ###########################################################

object fogata inherits Visual{
    method image() = "fogata-apagada.png"

    var property position = game.at(3,4)

   
}

// ###########################################################

object carpa inherits Visual{
    var property image = "carpa.png"

    var property position = game.at(6,4)

   
}
object leña inherits Visual{
    method image() = "leña.png"

    var property position = game.at(5,6)

    override method esAtravesable() = true

    method interaccion() {
        game.removeVisual(self)
        game.addVisual(puertaOeste)
        puertaOeste.irHacia(escenarioEntradaCabaña_v2)
        game.say(protagonista,"Gracias por la leña señor")
    }
}

object cabaña inherits Visual{
    method image() = "cabaña_entrada.png"

    var property position = game.at(5,6)

    override method esAtravesable() = true

    method interaccion(){}
}