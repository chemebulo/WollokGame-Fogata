import wollok.game.*
import protagonista.*
import enemigos.*

object arriba{
    method siguientePosicion(position){
        return game.at(position.x(), position.y() + 1)
    }
}

object abajo{
    method siguientePosicion(position){
        return game.at(position.x(), position.y() - 1)
    }
}

object derecha{
    method siguientePosicion(position){
        return game.at(position.x() + 1, position.y())
    }
}

object izquierda{
    method siguientePosicion(position){
        return game.at(position.x() - 1, position.y())
    }
}

object ejeX{
    method estaEnElMismoEjeQue(visual1, visual2){
        return visual1.position().x() == visual2.position().x()
    }

    method tieneQueAumentarConRespectoA(visual1, visual2) {
        return visual1.position().x() < visual2.position().x()
    }

    method puedeMoverEnEje(visual){
        const primeraDireccion = self.primeraDir()
        const segundaDireccion = self.segundaDir()

        return visual.puedoMover(primeraDireccion.siguientePosicion(visual.position())) and 
               visual.puedoMover(segundaDireccion.siguientePosicion(visual.position()))
    }

    method primeraDir() = derecha

    method segundaDir() = izquierda
}

object ejeY{
    method estaEnElMismoEjeQue(primeraVis, segundaVis) {
        return primeraVis.position().y() == segundaVis.position().y()
    }

    method tieneQueAumentarConRespectoA(primeraVis, segundaVis) {
        return primeraVis.position().y() < segundaVis.position().y()
    }

    method puedeMoverEnEje(visual){
        const primeraDireccion = self.primeraDir()
        const segundaDireccion = self.segundaDir()

        return visual.puedoMover(primeraDireccion.siguientePosicion(visual.position())) and 
               visual.puedoMover(segundaDireccion.siguientePosicion(visual.position()))
    }

    method primeraDir() = arriba

    method segundaDir() = abajo
}