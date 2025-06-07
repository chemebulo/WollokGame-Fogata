import protagonista.*
import visualesExtra.*
import direccion.*
import npcEstados.*
import npcMovimiento.*

object guardabosques inherits Visual{
    var property position = game.at(5,5)
    var property image    = "guardabosques-cabaña.png"
    var property vida     = 20
    var property estado   = armadoGuardabosques
    var dioleña           = false
    const property daño   = 1
    const enemigo         = protagonista
    const movimientoNPC   = new MovimientoNPC(visual = self)

   // ============================================================================================================= \\

    method perseguirEnemigo(){
        // El guardabosques persigue a su enemigo hasta estar a una celda lindante de distancia de él para atacarlo.
        movimientoNPC.perseguirEnemigo()
    }

   // ============================================================================================================= \\

    override method esAtravesable(){
        // Indica si el guardabosques si tiene colisión o no. En este caso describe que tiene colisión.
        return false
    }

    // ============================================================================================================= \\

    method puedeAtacarAlEnemigo(){ 
        // Indica si el guardabosques puede atacar a su enemigo. 
        // El guardabosques puede atacarlo si su enemigo se encuentra en una celda lindante a la suya.
        return estado.posicionesParaCalcularAtaque().contains(enemigo.position())
    }

    // ============================================================================================================= \\

    method estaSobreEnemigo(){
        // Indica si el guardabosques se encuentra sobre el enemigo o no.
        return self.position() == enemigo.position()
    }

    // ============================================================================================================= \\

    method estaVivo(){
        // Indica si el guardabosques se encuentra vivo o no.
        return self.vida() > 0
    }

    // ============================================================================================================= \\

    method cambiarImagen(direccion){ 
        // Cambia la imagen del guardabosques dependiendo de la dirección dada.
        self.image(estado.actual()+direccion.toString()+".png") 
    } 

    // ============================================================================================================= \\

    method xPos(){
        // Devuelve la coordenada "x" del guardabosques, especialmente se utiliza para conversar con el NPC.
        return self.position().x()
    }  

    // ============================================================================================================= \\

    method interaccion(){} // Representa la interacción del guardabosques con las puertas, en este caso no tiene ninguna.

    // ============================================================================================================= \\

    method atacarEnemigo(){
        // Representa el ataque del guardabosques hacia el enemigo.
        estado.ataque()
    }

    // ============================================================================================================= \\

    override method atacado(){
        // Emite un mensaje cuando el guardabosques es atacado por el enemigo.
        game.say(self,"Me esta atacando el protagonista")
    }
    
    // ============================================================================================================= \\

    method comprobarDialogo(){
        // Comprueba si el diálogo terminó para poder darle la leña al protagonista. 
        if(self.terminoDialogo() and (not dioleña)){
            self.darLeña()
            dioleña = true
        }
    }

    method terminoDialogo(){
        // Indica si el diálogo terminó.
        return enemigo.conversacionNPC().isEmpty() 
    }       
        
    method darLeña(){
        // Añade el visual de la leña en el mapa, para que el protagonista pueda agarrarla.
        game.addVisual(leña) 
    }

    // ============================================================================================================= \\

    method miCeldaArriba()    = arriba.siguientePosicion(position)
    method miCeldaAbajo()     = abajo.siguientePosicion(position)
    method miCeldaIzquierda() = izquierda.siguientePosicion(position)
    method miCeldaDerecha()   = derecha.siguientePosicion(position)
}

// ################################################################################################################# \\