import direccion.*
import visualesExtra.*
import npcEstados.*
import videojuego.*
import gestores.*

// ################################################################################################################################## \\

object protagonista inherits VisualConMovimiento(position = game.at(0,0), image = "prota-desarmado-abajo.png", vida = 100, daño = 3){
    var property estadoCombate        = pasivoProtagonista
    var property estadoCombateElegido = null
    const property vidaGestor         = gestorDeVida
    const property movimientoGestor   = gestorDeMovimiento
   
    // ============================================================================================================================== \\

    method mover(direccion){
        // Mueve al protagonista una celda hacia la dirección dada si puede mover hacia dicha dirección.
        movimientoGestor.mover(direccion, self)
    }

    method atacar(){
        // Representa el comportamiento del ataque del protagonista hacia su enemigo.   
        estadoCombate.atacarEnemigo()   
    }

    override method atacadoPor(visual){
        // Representa el comportamiento del protagonista cuando un enemigo suyo lo ataca.
        vidaGestor.atacadoPor(self, visual)
    }

    override method actualizarAMuerto(){
        // Actualiza el estado del protagonista a muerto, lo cual implica terminar el juego.
        super()
        videojuego.finalizarJuego()
    }
    
    override method imagenNueva(direccion){
        // Describe la imagen nueva del protagonista en base al estado de combate y a la dirección dada.
        return estadoCombate.actual()+direccion.toString()+".png"
    }

    method estaAlLadoDelNPC(npc){
        return ejeY.estaEnMismoEje(self, npc) and ejeX.estaAlLado(self, npc)
    }

    method mover(direccion, cantidad){
        // Hace que el personaje se mueva la cantidad de veces dada en la direccion dada. Solo se utiliza para testear. 
        (1 .. cantidad).forEach({n => self.mover(direccion)}) 
    }
}

// ################################################################################################################################## \\