object amiga{
    var property position = game.at(2,4)

    method image() = "amiga.png"

    method xPos(){
        return self.position().x()
    }
}

object fogata{
    var property image = "fogata.png"

    method position() = game.at(3,4)
}

object carpa {

    var property carpa = "carpa.png"

    method position() = game.at(6,4)
}