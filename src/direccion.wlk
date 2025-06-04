import wollok.game.*
import protagonista.*
import enemigos.*
import gestorColisiones.*

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

// ##############################################################################################

class Eje{
    method sumoEnEje(posicionAntigua, posicionNueva){
        return self.positionEnEje(posicionAntigua) + 1 == self.positionEnEje(posicionNueva)
    }

    method restoEnEje(posicionAntigua, posicionNueva){
        return self.positionEnEje(posicionAntigua) - 1 == self.positionEnEje(posicionNueva)
    }

    method positionEnEje(posicion)

    method primeraDir()

    method segundaDir()
}

object ejeX inherits Eje{
    override method positionEnEje(posicion) = posicion.x()

    override method primeraDir() = derecha

    override method segundaDir() = izquierda
}

object ejeY inherits Eje{
    override method positionEnEje(posicion) = posicion.y()

    override method primeraDir() = arriba

    override method segundaDir() = abajo
}

// ################################# DIRECCIONES PARA PUERTAS ##################################

object norte {
    method ubicacion (){
      return game.at(6,8)
    }
}

object sur {
    method ubicacion (){
      return game.at(6,0)
    }
}

object este {
    method ubicacion (){
      return game.at(12,4)
    }
}
object oeste {
    method ubicacion (){
      return game.at(0,4)
    }
}

// ################################### GESTOR DE DIRECCIONES ###################################

object gestorDeDirecciones {
    const ejePrimero = ejeX
    const ejeSegundo = ejeY

    method direccionALaQueSeMovio(posicionAntigua, posicionNueva) {
        return if (ejePrimero.sumoEnEje(posicionAntigua,  posicionNueva)) { ejePrimero.primeraDir() } else
               if (ejePrimero.restoEnEje(posicionAntigua, posicionNueva)) { ejePrimero.segundaDir() } else
               if (ejeSegundo.sumoEnEje(posicionAntigua,  posicionNueva)) { ejeSegundo.primeraDir() } else
                                                                          { ejeSegundo.segundaDir() }
    }
}

object gestorDePosiciones {
    method lindanteConvenienteHacia(posicion, visual){
        // Describe la celda lindante que más cerca está del visual dado.
        return gestorDeColisiones.lindantesSinObstaculos(posicion, visual).min({pos => pos.distance(visual.position())})
    }

    method lindantesDe(posicion){
        // Describe todas las celdas lindantes ortogonales y diagonales de la posición dada.
        return #{posicion.up(1), posicion.up(1).right(1), posicion.right(1), posicion.right(1).down(1), 
                 posicion.down(1), posicion.down(1).left(1), posicion.left(1), posicion.left(1).up(1)}
    }
}