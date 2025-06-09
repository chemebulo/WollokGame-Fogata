import protagonista.*
import visualesExtra.*
import direccion.*
import npcEstados.*
import npcMovimiento.*

class Enemigo inherits Visual{
    var property position  // Describe la posición actual del enemigo.
    var property image     // Describe la imagen actual del enemigo.
    var property vida      // Describe la vida actual del enemigo.
    const property daño    // Describe el daño del enemigo.
    const enemigo       = protagonista  // Desrcibe el enemigo que tiene el enemigo (el protagonista).
    const movimientoNPC = new MovimientoNPC(visual = self) // Representa el movimiento que tiene el enemigo.

    // ============================================================================================================= \\

    method perseguirEnemigo(){
        // El enemigo persigue a su enemigo hasta estar sobre él para poder atacarlo.
        movimientoNPC.perseguirEnemigo()
    }

    // ============================================================================================================= \\

    override method esAtravesable(){
        // Indica si el enemigo si tiene colisión o no. En este caso describe que tiene colisión.
        return false
    }

    // ============================================================================================================= \\

    method estaSobreEnemigo(){
        // Indica si el enemigo se encuentra sobre su enemigo o no.
        return self.position() == enemigo.position()
    }

    // ============================================================================================================= \\

    method estaVivo(){
        // Indica si el enemigo se encuentra vivo o no.
        return self.vida() > 0
    }
    
    // ============================================================================================================= \\

    override method atacado(){
        // Emite un mensaje cuando el enemigo es atacado por su enemigo.
        game.say(self,"Estoy siendo atacado, auxilio!")
    }

    // ============================================================================================================= \\

    method interaccion(){} // Representa la interacción del enemigo con las puertas, en este caso no tiene ninguna.

    // ============================================================================================================= \\

    method puedeAtacarAlEnemigo() // Indica si el enemigo puede atacar a su enemigo. 

    // ============================================================================================================= \\

    method atacarEnemigo() // Representa el ataque del enemigo hacia su enemigo.

    // ============================================================================================================= \\

    method cambiarImagen(direccion) // Cambia la imagen del enemigo dependiendo de la dirección dada.
}

// ################################################################################################################# \\

class Lobo inherits Enemigo(position = game.at(6,0), image = "lobo-derecha.png", vida = 3, daño = 1){
    
    override method puedeAtacarAlEnemigo(){
        // Indica si el lobo puede atacar a su enemigo. 
        return self.estaSobreEnemigo() and self.estaVivo()
    } 

    // ============================================================================================================= \\

    override method cambiarImagen(direccion){
        // Cambia la imagen del lobo dependiendo de la dirección dada. 
        self.image("lobo-"+direccion.toString()+".png")
    } 
}

// ################################################################################################################# \\

class LoboAgresivo inherits Lobo{
    override method atacarEnemigo(){
        // El lobo ataca al enemigo cada 1 segundo.
        game.schedule(1000, {enemigo.atacadoPor(self)})
    } 
}

// ################################################################################################################# \\

class LoboPasivo inherits Lobo{
    override method atacarEnemigo(){} // El lobo no ataca al enemigo, porque no es agresivo
}

// ################################################################################################################# \\

const loboAgresivo = new LoboAgresivo() // Representa a un lobo agresivo.
const loboPasivo   = new LoboPasivo()   // Representa a un lobo pasivo.

// ################################################################################################################# \\

object guardabosques inherits Enemigo(position = game.at(5,5), image = "guardabosques-cabaña.png", vida = 20, daño = 1){
    var property estado = armadoGuardabosques // Representa al estado del guardabosques que tenga en el momento.
    var dioleña         = false               // Indica si el guardabosques le dio leña a su enemigo (el protagonista).

    override method puedeAtacarAlEnemigo(){ 
        // Indica si el guardabosques puede atacar a su enemigo. 
        // El guardabosques puede atacarlo si su enemigo se encuentra en una celda lindante a la suya.
        return estado.posicionesParaCalcularAtaque().contains(enemigo.position())
    }

    override method cambiarImagen(direccion){ 
        // Cambia la imagen del guardabosques dependiendo de la dirección dada.
        self.image(estado.actual()+direccion.toString()+".png") 
    }

    override method atacarEnemigo(){
        // Representa el ataque del guardabosques hacia el enemigo.
        estado.ataque()
    } 

    // ============================================================================================================= \\

    method comprobarDialogo(){
        // Comprueba si el diálogo terminó para poder darle la leña a su enemigo (el protagonista). 
        if(self.terminoDialogo() and (not dioleña)){
            self.darLeña()
            dioleña = true
        }
    }

    method terminoDialogo(){
        // Indica si el diálogo con su enemigo (el protagonista) terminó.
        return enemigo.conversacionNPC().isEmpty() 
    }       
        
    method darLeña(){
        // Añade el visual de la leña en el mapa, para que su enemigo (el protagonista) pueda agarrarla.
        game.addVisual(leña) 
    }

    // ============================================================================================================= \\

    method miCeldaArriba()    = arriba.siguientePosicion(position)    // Metodos necesarios para ataque.    
    method miCeldaAbajo()     = abajo.siguientePosicion(position)     // Metodos necesarios para ataque.    
    method miCeldaIzquierda() = izquierda.siguientePosicion(position) // Metodos necesarios para ataque. 
    method miCeldaDerecha()   = derecha.siguientePosicion(position)   // Metodos necesarios para ataque. 
} 

// ################################################################################################################# \\