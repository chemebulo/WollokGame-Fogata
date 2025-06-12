import protagonista.*
import visualesExtra.*
import direccion.*
import npcEstados.*
import eventos.*

class Enemigo inherits VisualConMovimiento{
    var property estado    = new EnemigoVivo(visual = self) // Describe el estado del enemigo. Por defecto, está vivo.
    const property enemigo = protagonista  // Describe el enemigo que tiene el enemigo (el protagonista).

    // ============================================================================================================= \\

    method perseguirEnemigo(){
        // El enemigo persigue a su enemigo hasta estar sobre él para poder atacarlo dependiendo de su estado.
        estado.perseguirEnemigo()
    }

    // ============================================================================================================= \\

    method atacarEnemigo() // Representa el ataque del enemigo hacia su enemigo.

    // ============================================================================================================= \\

    override method atacadoPor(visual){
        // Emite un mensaje cuando el enemigo es atacado por su enemigo.
        estado.atacadoPor(visual)
    }

    // ============================================================================================================= \\

    override method actualizarAMuerto(){
        super()
        estado = new EnemigoMuerto()
        image = self.imagenMuerto()
    }

    // ============================================================================================================= \\

    method estaSobreEnemigo(){
        // Indica si el enemigo se encuentra sobre su enemigo o no.
        return self.position() == enemigo.position()
    }

    // ============================================================================================================= \\

    override method esAtravesable(){
        // Indica si el enemigo si tiene colisión o no. En este caso describe que tiene colisión.
        return false
    }

    // ============================================================================================================= \\

    method puedeAtacarAlEnemigo() // Indica si el enemigo puede atacar a su enemigo. 

    // ============================================================================================================= \\

    method imagenMuerto() // Describe la imagen del enemigo muerto.
}

// ################################################################################################################# \\

class Lobo inherits Enemigo(position = game.at(6,0), image = "lobo-derecha.png", vida = 10, daño = 1){
    const property comportamiento = agresivo
    const eventoLobo = new EventoLobo(loboEv = self)

    method eventoLobo() = eventoLobo

    override method imagenNueva(direccion){
        // Describe la imagen nueva del lobo en base a la dirección dada.
        return "lobo-"+direccion.toString()+".png"
    }

    // ============================================================================================================= \\

    override method imagenMuerto(){
        //
        return "lobo-muerto.png"
    }

    // ============================================================================================================= \\

    override method atacarEnemigo(){
        // El lobo ataca al enemigo cada 1 segundo.
        estado.atacarEnemigo()
    }

    override method puedeAtacarAlEnemigo(){
        // Indica si el lobo puede atacar a su enemigo. 
        return comportamiento.puedeAtacarAlEnemigo(self)
    } 
}

// ################################################################################################################# \\

object guardabosques inherits Enemigo(position = game.at(5,5), image = "guardabosques-cabaña.png", vida = 20, daño = 1){
    var property estadoCombate = armadoGuardabosques // Representa al estado de combate del guardabosques.
    var dioleña = false // Indica si el guardabosques le dio leña a su enemigo (el protagonista).

    // ============================================================================================================= \\

    override method imagenNueva(direccion){ 
        // Describe la imagen nueva del guardabosques en base a la dirección dada.
        return estadoCombate.actual()+direccion.toString()+".png"
    }

    // ============================================================================================================= \\

    override method imagenMuerto(){
        return "guardabosques-muerto.png"
    }

    // ============================================================================================================= \\

    override method atacarEnemigo(){
        // Representa el ataque del guardabosques hacia el enemigo.
        estadoCombate.ataque()
    } 

    // ============================================================================================================= \\

    override method puedeAtacarAlEnemigo(){ 
        // Indica si el guardabosques puede atacar a su enemigo. 
        // El guardabosques puede atacarlo si su enemigo se encuentra en una celda lindante a la suya.
        return estadoCombate.posicionesParaCalcularAtaque().contains(enemigo.position())
    }

    // ============================================================================================================= \\
    // REFACTORIZAR Y MOVER LA MAYOR PARTE POSIBLE A OTRO LADO DE TODO ESTO:

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