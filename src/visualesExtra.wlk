import protagonista.*
import escenarios.*
import confgEscSig.*
import confgEscenarios.*
import npcEstados.*
import enemigos.*
import puertas.*

class Visual{
    method esAtravesable(){
        // Indica si el visual es atravesable o no, en este caso no es atravesable.
        return false
    }

    method atacadoPor(visual){} // Representa el comportamiento del visual al ser atacado por otro visual.
}

// ########################################################################################################################## \\

class VisualConMovimiento inherits Visual{
    var property position       // Describe la posición actual del visual.
    var property vida           // Describe la vida del visual.
    var property image  = null  // Describe la imagen del visual.
    const property daño = 1     // Describe el daño del visual.

    method cambiarImagen(direccion){
        // Cambia la imagen del visual dependiendo de la dirección dada. 
        self.image(self.imagenNueva(direccion))
    }

    method estaVivo(){
        // Indica si el visual se encuentra vivo o no.
        return self.vida() > 0
    }

    method actualizarAMuerto(){
        // Actualiza la vida del visual a cero.
        vida = 0
    }

    method imagenMuerto(){
        // Describe la imagen del enemigo muerto.
        return "muerto-"+self.image()
    }

    method imagenTemporal(){
        return "atacando-"+self.image()
    }

    method imagenNueva(direccion) // Describe la imagen nueva del visual en base a la dirección dada.

    method interaccion(){} // Representa la interacción del visual con los diferentes objetos, en este caso no tiene ninguna.
}

// ########################################################################################################################## \\

object amiga inherits Visual{
    var property position = game.at(2,4)
    const property image    = "amiga.png"
    const property dialogo  = []
}

// ########################################################################################################################## \\

object fogataOBJ inherits Visual{
    var property position = game.at(3,4)
    const property image    = "fogata-apagada.png"
}

// ########################################################################################################################## \\

object carpa inherits Visual{
    var property position = game.at(6,4)
    const property image    = "carpa.png"
}

// ########################################################################################################################## \\

object leña inherits Visual{
    var property position = game.at(5,6)
    const property image    = "leña.png"

    override method esAtravesable(){
        return true
    }

    method interaccion() {
        game.removeVisual(self)
        game.addVisual(puertaEntradaCabaña)
        puertaEntradaCabaña.irHacia(entradaCabaña)
        game.say(protagonista,"Gracias por la leña")
        game.say(guardabosques,"No hay de que.Tenga cuidado nomas que hay lobos por estos lados")
        entradaCabaña.configuradorTotal(confg_escenarioEntradaCabaña_v2,confg_escSig_escenarioEntradaCabaña_v2)     
    }
}

// ########################################################################################################################## \\

object cabañaOBJ inherits Visual{
    var property position = game.at(5,6)
    const property image    = "cabaña_entrada.png"

    override method esAtravesable(){
        return true
    }

    method interaccion(){}

    
}

// ########################################################################################################################## \\
object cuevaOBJ inherits Visual{
    var property position = game.at(2,5)
    const property image = "cueva.png"
    
    override method esAtravesable(){
        return true
    }

    method interaccion(){}
}

object graneroOBJ inherits Visual{
    var property position =game.at(6,6)
    const property image = "granero.png"

    override method esAtravesable(){
        return true
    }
    method interaccion(){}
}

// ####################################################################################################### //

object hacha inherits Visual{
    var property position = game.at(5,5) // Sería const? 
    var property image    = "hacha.png"  // Sería const?

    override method esAtravesable(){
        return true 
    }

    method interaccion(){
        game.removeVisual(self)
        protagonista.estadoCombate(armadoProtagonista)
        game.say(protagonista, "Ya puedo defenderme de esos bichos")
    }
}
object nota inherits Visual{
    var property position = game.at(5,5)
    var property image = "nota.png"
    override method esAtravesable(){
        return true 
    }
      method interaccion(){
        game.removeVisual(self)
        game.say(protagonista, "SI SOBREVIVISTE TE ESPERO EN LA CUEVA...")
        game.addVisual(puertaEntradaCabaña)
    }
}
// ########################################################################################################################## \\

class Obstaculo inherits Visual{
    var property position
    const property image = "obstaculo.png"
}

// ########################################################################################################################## \\

class ParedInvisible inherits Visual{
    var property position
    const property image = null
}

// ########################################################################################################################## \\

object gameover{
    const property position = game.at(0,0)
    const property image    = "game-over.png"
}

// ########################################################################################################################## \\

object juegoGanado{
    const property position = game.at(0,0)
    const property image    = "game-win.png"
}

