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
    method estanEnElMismoEje(primeraVis, segundaVis) {
        return self.positionDeEnElEje(primeraVis) == self.positionDeEnElEje(segundaVis)
    }

    method necesitaAcercarseA(primeraVis, segundaVis) {
        return self.positionDeEnElEje(primeraVis) < self.positionDeEnElEje(segundaVis) 
    }

    method puedeMoverEnEjeHacia(primeraVis, segundaVis){
        const nuevaPosicionPrimeraDireccion = self.primeraDir().siguientePosicion(primeraVis.position())
        const nuevaPosicionSegundaDireccion = self.segundaDir().siguientePosicion(primeraVis.position())

        return gestorDeColisiones.puedeMoverHacia(nuevaPosicionPrimeraDireccion, segundaVis) and 
               gestorDeColisiones.puedeMoverHacia(nuevaPosicionSegundaDireccion, segundaVis)
    }

    method mismoEjeEntreYPuedeMoverA(primeraVis, segundaVis, eje) {
        return self.estanEnElMismoEje(primeraVis, segundaVis) and eje.puedeMoverEnEjeHacia(primeraVis, segundaVis)
    }

    method positionDeEnElEje(visual)

    method primeraDir()

    method segundaDir()
}

object ejeX inherits Eje{
    override method positionDeEnElEje(visual) = visual.position().x()

    override method primeraDir() = derecha

    override method segundaDir() = izquierda
}

object ejeY inherits Eje{
    override method positionDeEnElEje(visual) = visual.position().y()

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