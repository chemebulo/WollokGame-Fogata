import protagonista.*
import escenariosManager.*
import npcEstados.*
import enemigos.*
import puertas.*
import videojuego.*

// ########################################################################################################################## \\

class Visual{
    var property position = game.at(0,0) // Por defecto.
    var property image    = null         // Por defecto.
    var esAtravesable     = false
    
    // ====================================================================================================================== \\

    method interaccion(){}

    method atacadoPor(visual){} // Representa el comportamiento del visual al ser atacado por otro visual.

    method cambiarAAtravesable(){
        esAtravesable = true
    }

    // ====================================================================================================================== \\

    method esAtravesable(){
        return esAtravesable
    }
}

// ########################################################################################################################## \\

class VisualConMovimiento inherits Visual{
    var property vida       // Describe la vida del visual.
    const property daño = 1 // Describe el daño del visual.

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
}

// ########################################################################################################################## \\

class VisualAtravesable inherits Visual(esAtravesable = true){}

// ########################################################################################################################## \\

class VisualInteractuable inherits VisualAtravesable{
    const bloqueInteraccion
    
    override method interaccion(){
        bloqueInteraccion.apply(self)
    }
}

// ########################################################################################################################## \\

class VisualObstaculo inherits Visual{}

// ########################################################################################################################## \\

const leña        = new VisualInteractuable(image = "leña.png", position = game.at(5,5), bloqueInteraccion = interaccionLeña)
const nota        = new VisualInteractuable(image = "nota.png", position = game.at(5,5), bloqueInteraccion = interaccionNota)
const auto        = new VisualInteractuable(image = "auto.png", position = game.at(5,5), bloqueInteraccion = interaccionAuto)
const cabañaOBJ   = new VisualAtravesable(image = "cabaña_entrada.png", position = game.at(5,6))
const graneroOBJ  = new VisualAtravesable(image = "granero.png",        position = game.at(6,6))
const fogataOBJ   = new Visual(image = "fogata.png", position = game.at(3,4))
const amiga       = new Visual(image = "amiga.png",  position = game.at(2,4))
const carpa       = new Visual(image = "carpa.png",  position = game.at(6,4))
const gameover    = new Visual(image = "game-over.png")
const juegoGanado = new Visual(image = "game-win.png")
const hacha       = new Arma(image = "hacha.png",    position = game.at(5,5), nuevoEstado = agresivoProtagonistaH)
const tridente    = new Arma(image = "tridente.png", position = game.at(6,6), nuevoEstado = agresivoProtagonistaT)
const manopla     = new Arma(image = "manopla.png",  position = game.at(7,7), nuevoEstado = agresivoProtagonistaM)

// ########################################################################################################################## \\

const interaccionLeña = {v => game.removeVisual(v)
                              game.addVisual(puertaEntradaCabaña)
                              puertaEntradaCabaña.irHacia(entradaCabaña)
                              game.say(protagonista, "Gracias por la leña.")
                              game.say(guardabosques, "No hay de que, tenga cuidado que hay lobos por la zona.")
                              entradaCabaña.configuradorTotal(entradaCabañaConfgV2, entradaCabañaCESv2)}

const interaccionNota = {v => game.removeVisual(v)
                              game.say(protagonista, "SI SOBREVIVISTE TE ESPERO EN LA CUEVA...")
                              game.addVisual(puertaEntradaCabaña)}

const interaccionAuto = {v => game.removeVisual(v); videojuego.juegoGanado()}

// ########################################################################################################################## \\

class Arma inherits VisualAtravesable{
    const usuario = protagonista
    const property nuevoEstado 

    override method interaccion(){
        game.say(protagonista, "Pulsa K para atacar")
        videojuego.removerVisualesArmas()
        usuario.agarrarArma(self)
    }
}

// ########################################################################################################################## \\

class Obstaculo inherits VisualObstaculo(image = "obstaculo.png"){}

// ########################################################################################################################## \\

class ParedInvisible inherits VisualObstaculo(image = null){}

// ########################################################################################################################## \\