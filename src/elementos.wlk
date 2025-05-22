class Visual{
    method esAtravesable(){
        return true
    }
}

object amiga inherits Visual{
    method image() = "amiga.png"

    var property position = game.at(2,4)

    override method esAtravesable() = false

    method xPos() = self.position().x()
}

object fogata inherits Visual{
    method image() = "fogata-apagada.png"

    var property position = game.at(3,4)

    override method esAtravesable() = false
}

object carpa inherits Visual{
    var property image = "carpa.png"

    var property position = game.at(6,4)

    override method esAtravesable() = false
}