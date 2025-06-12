import protagonista.*
import enemigos.*
import npcMovimiento.*
import gestores.*

/*
    El protagonista inicia el juego desarmado y solo cuando interactua con el hacha pasa a estar armado el resto del juego hasta 
    el final
    El guardabosques pasa a estado armado al final del juego
*/

// ESTADOS DEL PROTAGONISTA Y GUARDABOSQUES
const desarmadoProtagonista  = new Desarmado(image = "prota-desarmado-")
const desarmadoGuardabosques = new Desarmado(image = "")
const armadoGuardabosques    = new ArmadoConHacha(pj = guardabosques, imagenActual = "guardabosques-", imagenTemporal = "guardabosques-cabaña.png")
const armadoProtagonista     = new ArmadoConHacha(pj = protagonista,  imagenActual = "prota-armado-",  imagenTemporal = "ataque-prota.png")

// CLASES DE ESTADO
class Desarmado{
    const image // parte del nombre de una imagen necesario para dibujar dependiendo la direccion
    
    method actual(){
        return image
    }
    
    method ataque(){}
}

class ArmadoConHacha{
    const pj             = null  // personaje que ataca
    const imagenActual   = "" // parte del nombre de una imagen necesario para dibujar dependiendo la direccion
    const modoAtaque     = new HachazoCruz(atacante= self.pj())
    const animacion      = new AnimacionAtaque(imagenTemp = self.imagenTemporal(),pjAnimado= self.pj())
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

    method ataque(){
        animacion.animarAtaque()
        modoAtaque.ataqueArma()
    }
    
    method modoAtaque(){
        // Llamado por protagonista.
        return modoAtaque
    } 

    method posicionesParaCalcularAtaque(){
        return modoAtaque.posicionesAAtacar()
    }
}

// ANIMACION Y TIPO DE ATAQUE

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
        game.schedule(200,{game.removeVisual(pjAnimado);pjAnimado.image(imagenActual);game.addVisual(pjAnimado)})
    }
}

class HachazoCruz{
    /*
        FUNCIONAMIENTO DEL ATAQUE EN CRUZ:
        atacarEnPosiciones(posiciones) : dada una coleccion de posiciones(celdas) ataca a los objetos en esas posiciones
        atacarObjetos(objetos) : dada una coleccion de objetos de una posicion(celda) ataca a esos objetos
        objetosEnPosicionAtacada(pos) : dada una posicion, retorna una lista con todos los objetos en esa posicion
        posicionesAtacar() : retorna las posiciones donde se atacara el cruz a partir de la posicion del personaje
    */
    const atacante 
    
    method ataqueArma(){
        self.atacarEnPosiciones(self.posicionesAAtacar())
    }

    method atacarEnPosiciones(coleccionPosiciones){
        coleccionPosiciones.forEach({pos => self.atacarObjetos(self.objetosEnPosicionAtacada(pos))})
    }

    method atacarObjetos(coleccionObjetos){ 
        coleccionObjetos.forEach({obj => obj.atacadoPor(atacante)})
    }

    method objetosEnPosicionAtacada(posicion){
        return game.getObjectsIn(posicion)
    } 
    
    method posicionesAAtacar() = [atacante.position().down(1),
                                  atacante.position().up(1),
                                  atacante.position().left(1),
                                  atacante.position().right(1)]
}

class HachazoEnLugar inherits HachazoCruz{
    override method ataqueArma(){
        self.atacarObjetos(self.objetosEnPosicionAtacada(atacante.position()))
    }

    override method objetosEnPosicionAtacada(posicion) { 
        return super(posicion).copyWithout(atacante)
    }
} 

// ######################################################################################################################## //

class EnemigoVivo{
    const visual //
    const vidaGestor = gestorDeVida //
    const movimientoNPC = new MovimientoNPC(npc = visual) //

    method perseguirEnemigo(){
        // El enemigo persigue a su enemigo hasta estar sobre él para poder atacarlo.
        movimientoNPC.perseguirEnemigo()
    }

    method atacarEnemigo(){
        // El lobo ataca al enemigo cada 1 segundo.
        game.schedule(1000, {visual.enemigo().atacadoPor(visual)})
    }

    method atacadoPor(enemigo){
        // Emite un mensaje cuando el enemigo es atacado por su enemigo.
        vidaGestor.atacadoPor(visual, enemigo)
    }
}

class EnemigoMuerto{
    method perseguirEnemigo(){} //

    method atacarEnemigo(){} //

    method atacadoPor(enemigo){} //
}

// ######################################################################################################################## //

object agresivo{

    method puedeAtacarAlEnemigo(visual){
        // Indica si el lobo puede atacar a su enemigo. 
        return visual.estaSobreEnemigo()
    } 
}

// ######################################################################################################################## //

object pasivo{

    method puedeAtacarAlEnemigo(visual){
        // Indica si el lobo puede atacar a su enemigo. En este caso, no puede. 
        return false
    }
}