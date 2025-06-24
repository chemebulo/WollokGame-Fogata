import protagonista.*
import enemigos.*
import npcMovimiento.*
import gestores.*
import direccion.*
import visualesExtra.*
import npcAtaques.*
/*
    El protagonista inicia el juego desarmado y solo cuando interactua con el hacha/tridente/manopla pasa a estar armado 
    el resto del juego hasta el final de la pelea con guardabosques
    El guardabosques pasa a estado armado al final del juego
*/

// ########################################################################################################################## \\
// ESTADOS DEL PROTAGONISTA Y GUARDABOSQUES

const desarmadoProtagonista  = new Desarmado(image = "prota-desarmado-")
const desarmadoGuardabosques = new Desarmado(image = "")
const armadoGuardabosques    = new ArmadoConEscopeta(pj = guardabosques, imagenActual = "guardabosques-", imagenTemporal = "ataque-guardabosques-escopeta.png")
const armadoProtagonista     = new ArmadoConHacha(pj = protagonista,  imagenActual = "prota-armado-",  imagenTemporal = "ataque-prota.png")
const armadoProtagonista2    = new ArmadoConTridente(pj = protagonista, imagenActual = "prota-armado-",    imagenTemporal = "ataque-prota-tridente.png")
const armadoProtagonista3    = new ArmadoConManopla(pj = protagonista,  imagenActual = "prota-desarmado-", imagenTemporal = "ataque-prota-manopla.png")

// ########################################################################################################################## \\

class Desarmado{
    const image // parte del nombre de una imagen necesario para dibujar dependiendo la direccion
    
    method actual(){
        return image
    }
    
    method atacarEnemigo(){}
}

// ########################################################################################################################## \\

class Armado {
    const pj             = null  // personaje que ataca
    const imagenActual   = "" // parte del nombre de una imagen necesario para dibujar dependiendo la direccion
    const modoAtaque     
    const animacion      = new AnimacionAtaque(imagenTemp = imagenTemporal, pjAnimado= pj)
    const imagenTemporal // la imagen que se muestra al atacar

    method imagenTemporal(){
        return imagenTemporal
    }

    method actual(){
        return imagenActual
    } 

    method pj(){
        return pj
    }

    method atacarEnemigo(){
        modoAtaque.ataqueArma()
        animacion.animarAtaque()
    }
    
    method modoAtaque(){
        // Llamado por protagonista.
        return modoAtaque
    } 

    method posicionesParaCalcularAtaque(){
        return modoAtaque.posicionesAAtacar()
    }

    method puedeAtacarAlEnemigo(){
        // Indica si el lobo puede atacar a su enemigo. En este caso, no puede. 
        return pj.estaSobreEnemigo()
    }
}

// ESCOPETA DE GUARDABOSQUES

class ArmadoConEscopeta inherits Armado(pj=guardabosques,
                                     //modoAtaque = escopetaGuardabosques,
                                     modoAtaque= new Escopeta(tirador=pj,
                                                 enemigo=protagonista,
                                                 cartucho = cartuchoGuardabosques),
                                                imagenTemporal="guardabosques-dispara.png" ){

    // va a disparar en todo momento, no me importa donde este el prota
    override method puedeAtacarAlEnemigo() = true 
}

    const cartuchoGuardabosques =  new Cartucho(misBalas= [bala1,bala2,bala3,bala4,bala5,bala6])

    class Cartucho {
        const property misBalas = [] // una lista que funciona como Queue
    }

    const bala1 = new Bala()
    const bala2 = new Bala()
    const bala3 = new Bala()
    const bala4 = new Bala()
    const bala5 = new Bala()
    const bala6 = new Bala()

// ESCOPETA DE GUARDABOSQUES     

class ArmadoConHacha inherits Armado(modoAtaque = new AtaqueHacha(atacante = pj)){}
  
class ArmadoConTridente inherits Armado(modoAtaque = new AtaqueTridente(atacante = pj)){}

class ArmadoConManopla inherits Armado(modoAtaque = new AtaqueManopla(atacante = pj)){}   

// ########################################################################################################################## \\



// ########################################################################################################################## \\

class EnemigoVivo{
    const visual //
    const vidaGestor    = gestorDeVida //
    const movimientoNPC = new MovimientoNPC(npc = visual) //
    const animacion     = new AnimacionAtaque(pjAnimado = visual, imagenTemp = visual.imagenTemporal())

    method perseguirEnemigo(){
        // El enemigo persigue a su enemigo hasta estar sobre él para poder atacarlo.
        movimientoNPC.perseguirEnemigo()
    }

    method atacarEnemigo(){
        // El lobo ataca al enemigo cada 1 segundo.
        if (self.puedeAtacarAlEnemigo()){ 
            animacion.animarAtaque()
            game.schedule(1, {visual.emitirSonidoEnojado();
                              visual.enemigo().atacadoPor(visual)})
        }
    }

    method puedeAtacarAlEnemigo(){
        // Indica si el lobo puede atacar a su enemigo. 
        return visual.estaSobreEnemigo()
    } 

    method atacadoPor(enemigo){
        // Emite un mensaje cuando el enemigo es atacado por su enemigo.
        vidaGestor.atacadoPor(visual, enemigo)
    }
}

// ########################################################################################################################## \\

class EnemigoMuerto{
    method perseguirEnemigo(){} //

    method atacarEnemigo(){} //

    method atacadoPor(enemigo){} //
}