

class Visual{
    method esAtravesable(){
        return true
    }

    
}

object amiga inherits Visual{
    var property position = game.at(2,4)

    method image() = "amiga.png"

    method xPos(){ 
        return self.position().x()
    }

    override method esAtravesable() = false

    
}

object fogata inherits Visual{
    method image() = "fogata.png"

    var  property position = game.at(6,4)

    override method esAtravesable() = false
}

object carpa inherits Visual{

    method image() = "carpa.png"

    var  property position = game.at(2,2)

    override method esAtravesable() = false
     
}