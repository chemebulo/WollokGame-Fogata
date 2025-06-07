import protagonista.*
import visualesExtra.*
import npcMovimiento.*

class Lobo inherits Visual{
    var property position  = game.at(6,0)
    var property image     = "lobo-derecha.png"
    var property vida      = 3
    const property daño    = 1
    const enemigo          = protagonista
    const movimientoNPC    = new MovimientoNPC(visual = self)

   // ============================================================================================================= \\

    method perseguirEnemigo(){
        // El lobo persigue a su enemigo hasta estar sobre él para poder atacarlo.
        movimientoNPC.perseguirEnemigo()
    }

    // ============================================================================================================= \\

    override method esAtravesable(){
        // Indica si el lobo si tiene colisión o no. En este caso describe que tiene colisión.
        return false
    }

    // ============================================================================================================= \\

    method puedeAtacarAlEnemigo(){
        // Indica si el lobo puede atacar a su enemigo. 
        // El lobo puede atacar a su enemigo si está sobre su enemigo y él está vivo.
        return self.estaSobreEnemigo() and self.estaVivo()
    }

    // ============================================================================================================= \\

    method estaSobreEnemigo(){
        // Indica si el lobo se encuentra sobre el enemigo o no.
        return position == enemigo.position()
    }

    // ============================================================================================================= \\

    method estaVivo(){
        // Indica si el lobo se encuentra vivo o no.
        return self.vida() > 0
    }

    // ============================================================================================================= \\

    method cambiarImagen(direccion){ 
        // Cambia la imagen del lobo dependiendo de la dirección dada.
        self.image("lobo-"+direccion.toString()+".png") 
    } 

    // ============================================================================================================= \\

    method interaccion() {} // Representa la interacción del lobo con las puertas, en este caso no tiene ninguna.

    // ============================================================================================================= \\

    method atacarEnemigo() // Representa el ataque del lobo hacia el enemigo.

    // ============================================================================================================= \\

    override method atacado(){
        // Emite un mensaje cuando el lobo es atacado por el enemigo.
        game.say(self,"Estoy siendo atacado, auxilio")
    }
}

// ################################################################################################################# \\

class LoboAgresivo inherits Lobo {
    override method atacarEnemigo(){
        game.schedule(1000, {enemigo.atacadoPor(self)})
    } 
}

// ################################################################################################################# \\

class LoboPasivo inherits Lobo {
    override method atacarEnemigo() {}
}

// ################################################################################################################# \\

const loboAgresivo = new LoboAgresivo()
const loboPasivo = new LoboPasivo()

// ################################################################################################################# \\