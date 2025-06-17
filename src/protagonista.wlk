import direccion.*
import visualesExtra.*
import npcEstados.*
import videojuego.*
import gestores.*

object protagonista inherits VisualConMovimiento(position = game.at(0,0), image = "prota-desarmado-abajo.png", vida = 10, daño = 1){
    var property conversadorActual  = self
    var property conversacionNPC    = []
    var property npcActual          = null 
    var property estoyAtacando      = false
    var property estadoCombate      = desarmadoProtagonista // Verifica si estoy dentro del tablero y los objetos que no puedo atravesar.
    const property vidaGestor       = gestorDeVida
    const property movimientoGestor = gestorDeMovimiento
    const property dialogoGestor    = gestorDeDialogo

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
        return estadoCombate.actual() + direccion.toString() + ".png"
    }

    method interactuarNPC(){
        // El protagonista interactúa con el NPC que tenga al lado (si es que tiene alguno).
        dialogoGestor.interactuarNPC(self)
    }

    method estaAlLadoDelNPC(){
        return ejeY.estaEnMismoEje(self, npcActual) and ejeX.estaAlLado(self, npcActual)
    }

    method mover(direccion, cantidad){
        // Hace que el personaje se mueva la cantidad de veces dada en la direccion dada.
        // Solo para testear. 
        (1 .. cantidad).forEach({n => self.mover(direccion)}) 
    }
}