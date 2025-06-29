import protagonista.*
import escenariosManager.*
import npcEstados.*
import enemigos.*
import puertas.*
import videojuego.*

class Visual{
    var property position      = game.at(0,0) // Por defecto.
    var property image         = null         // Por defecto.
    var property esAtravesable = false
    
    method interaccion(){}

    method atacadoPor(visual){} // Representa el comportamiento del visual al ser atacado por otro visual.

    method cambiarAAtravesable(){
        esAtravesable = true
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

class VisualAtravasable inherits Visual(esAtravesable = true){}

// ########################################################################################################################## \\

class VisualInteractuable inherits VisualAtravasable{
    const bloqueInteraccion
    
    override method interaccion(){
        bloqueInteraccion.apply(self)
    }
}

// ########################################################################################################################## \\

class VisualObstaculo inherits Visual{}

// ########################################################################################################################## \\

const amiga     = new Visual(position = game.at(2,4), image = "amiga.png")
const fogataOBJ = new Visual(position = game.at(3,4), image = "fogata-apagada.png")
const carpa     = new Visual(position = game.at(6,4), image = "carpa.png")

const leña = new VisualInteractuable(image = "leña.png", position = game.at(5,5), bloqueInteraccion = interaccionLeña)
const nota = new VisualInteractuable(image = "nota.png", position = game.at(5,5), bloqueInteraccion = interaccionNota)
const auto = new VisualInteractuable(image = "auto.png", position = game.at(5,5), bloqueInteraccion = interaccionAuto)

const interaccionLeña = {v => game.removeVisual(v)
                              game.addVisual(puertaEntradaCabaña)
                              puertaEntradaCabaña.irHacia(entradaCabaña)
                              game.say(protagonista,"Gracias por la leña")
                              game.say(guardabosques,"No hay de que, tenga cuidado que hay lobos por la zona")
                              entradaCabaña.configuradorTotal(entradaCabañaC_v2, entradaCabañaCES_v2)}

const interaccionNota = {v => game.removeVisual(v)
                              game.say(protagonista, "SI SOBREVIVISTE TE ESPERO EN LA CUEVA...")
                              game.addVisual(puertaEntradaCabaña)}

const interaccionAuto = {v => game.removeVisual(v); videojuego.juegoGanado()}

const cabañaOBJ  = new VisualAtravasable(position = game.at(5,6), image = "cabaña_entrada.png")
const graneroOBJ = new VisualAtravasable(position = game.at(6,6), image = "granero.png")

// ########################################################################################################################## \\

class Arma inherits VisualAtravasable{
    const bloque

    override method interaccion(){
        game.say(protagonista, "Pulsa K para atacar")
        bloque.apply(self)
    }
}

const hacha    = new Arma(image = "hacha.png",    position = game.at(5,5), bloque = interaccionHacha)
const tridente = new Arma(image = "tridente.png", position = game.at(6,6), bloque = interaccionTridente)
const manopla  = new Arma(image = "manopla.png",  position = game.at(7,7), bloque = interaccionManopla)

const interaccionHacha = {ar => game.removeVisual(ar);
                                game.removeVisual(tridente);
                                game.removeVisual(manopla);
                                protagonista.estadoCombate(agresivoProtagonistaH)
                                protagonista.estadoCombateElegido(agresivoProtagonistaH)}

const interaccionTridente = {ar => game.removeVisual(ar);
                                   game.removeVisual(hacha);
                                   game.removeVisual(manopla);
                                   protagonista.estadoCombate(agresivoProtagonistaT)
                                   protagonista.estadoCombateElegido(agresivoProtagonistaT)}

const interaccionManopla = {ar => game.removeVisual(ar);
                                  game.removeVisual(hacha);
                                  game.removeVisual(tridente);
                                  protagonista.estadoCombate(agresivoProtagonistaM)
                                  protagonista.estadoCombateElegido(agresivoProtagonistaM)}

// ########################################################################################################################## \\

class Obstaculo inherits VisualObstaculo(image = "obstaculo.png"){}

class ParedInvisible inherits VisualObstaculo(image = null){}

const gameover = new Visual(image = "game-over.png")
const juegoGanado = new Visual(image = "game-win.png")

// ########################################################################################################################## \\