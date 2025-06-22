import protagonista.*
import enemigos.*
import npcMovimiento.*
import gestores.*
import direccion.*
import visualesExtra.*
import ataqueGuardabosquesProv.*
/*
    El protagonista inicia el juego desarmado y solo cuando interactua con el hacha pasa a estar armado el resto del juego hasta 
    el final
    El guardabosques pasa a estado armado al final del juego
*/

// ########################################################################################################################## \\
// ESTADOS DEL PROTAGONISTA Y GUARDABOSQUES

const desarmadoProtagonista  = new Desarmado(image = "prota-desarmado-")
const desarmadoGuardabosques = new Desarmado(image = "")
const armadoGuardabosques    = new ArmadoEscopeta(pj = guardabosques, imagenActual = "guardabosques-", imagenTemporal = "ataque-guardabosques-escopeta.png")
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

class ArmadoConHacha inherits Armado(modoAtaque = new AtaqueHacha(atacante = pj)){}
  
class ArmadoConTridente inherits Armado(modoAtaque = new AtaqueTridente(atacante = pj)){}

class ArmadoConManopla inherits Armado(modoAtaque = new AtaqueManopla(atacante = pj)){}   

// ########################################################################################################################## \\

class AnimacionAtaque{
    /*
        animarAtaque() : realiza una secuencia de de instrucciones que consisten en remover/agregar y settear la imagen de un visual
                         para dar sensacion de animacion
    */
    const imagenTemp = ""   // la imagen que se muestra cuando se ataca
    const pjAnimado  = null // el visual que ataca

    method animarAtaque(){
        const imagenActual = pjAnimado.image()

        game.removeVisual(pjAnimado) 
        pjAnimado.image(imagenTemp)
        game.addVisual(pjAnimado)
        game.schedule(200,{game.removeVisual(pjAnimado); 
                           pjAnimado.image(imagenActual); 
                           game.addVisual(pjAnimado)})
    }
    method atacadoPor(visual){}
 
    method esAtravesable() = true
}

// ########################################################################################################################## \\
class Ataque {
    const atacante

    method ataqueArma(){
        self.posicionesAAtacar().forEach({pos => self.atacarEnPosicion(pos)})
    }
  
    method atacarEnPosicion(pos){
         self.objetosEnPosicion(pos).forEach({obj => obj.atacadoPor(atacante)})
    }
 

    method objetosEnPosicion(posicion){
        return game.getObjectsIn(posicion)
    } 
    
    method posicionesAAtacar()
}

class AtaqueHacha inherits Ataque{
        
    override method posicionesAAtacar() = [atacante.position().down(1),
                                           atacante.position().up(1),
                                           atacante.position().left(1),
                                           atacante.position().right(1)]
}

class AtaqueTridente inherits Ataque{
    
    override method posicionesAAtacar() = [atacante.position().left(1),
                                           atacante.position().left(2),
                                           atacante.position().right(1),
                                           atacante.position().right(2)]
}
class AtaqueManopla inherits Ataque{
    
    override method posicionesAAtacar(){
        return [atacante.position()]
    }

    override method objetosEnPosicion(posicion){
        return game.getObjectsIn(posicion).copyWithout(atacante)
    } 
}

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