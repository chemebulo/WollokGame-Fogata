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
    const property vg               = videojuego
    const property vidaGestor       = gestorDeVida
    const property movimientoGestor = gestorDeMovimiento

    // ============================================================================================================= \\

    method mover(direccion){
        // Mueve al protagonista una celda hacia la dirección dada si puede mover hacia dicha dirección.
        movimientoGestor.mover(direccion, self)
    }

    // ============================================================================================================= \\

    method atacar(){
        //
        estadoCombate.ataque()
    }

    // ============================================================================================================= \\

    override method atacadoPor(visual){
        //
        vidaGestor.atacadoPor(self, visual)
    }

    // ============================================================================================================= \\

    override method actualizarAMuerto(){
        //
        super()
        vg.finalizarJuego()
    }
    
    // ============================================================================================================= \\
    
    override method imagenNueva(direccion){
        //
        return estadoCombate.actual() + direccion.toString() + ".png"
    }

    // ============================================================================================================= \\
    // REFACTORIZAR Y MOVER LA MAYOR PARTE POSIBLE A OTRO LADO DE TODO ESTO:

    method interactuarNPC(){
        if (self.estaAlLadoDe(npcActual)){self.conversar()}
    }

    method estaAlLadoDe(npc){
        return ejeY.estaEnMismoEje(self, npc) and ejeX.estaAlLado(self, npc)
    }

    method conversar() {
        if(not self.esDialogoFinal()){
            game.say(conversadorActual,self.dialogoActual())
            conversacionNPC.remove(self.dialogoActual())
            self.cambiarConversador()
        }
    }

    method dialogoActual(){
        return conversacionNPC.first()
    }

    method esDialogoFinal(){
        return conversacionNPC.isEmpty()
    }

    method cambiarConversador(){ 
        if (self.esMiTurnoDeHablar()){ conversadorActual = self } else { conversadorActual = npcActual }
    }

    method esMiTurnoDeHablar(){
        return conversacionNPC.size().even()
    }
    
    method resetearDialogo(){
        conversacionNPC = []
        conversadorActual = self
    }

    // ============================================================================================================= \\

    method mover(direccion, cantidad){
        // Hace que el personaje se mueva la cantidad de veces dada en la direccion dada. 
        (1 .. cantidad).forEach({n => self.mover(direccion)})        // Solo para testear.
    }

    method miCeldaArriba()    = arriba.siguientePosicion(position)    // Solo para testear.
    method miCeldaAbajo()     = abajo.siguientePosicion(position)     // Solo para testear.
    method miCeldaIzquierda() = izquierda.siguientePosicion(position) // Solo para testear.
    method miCeldaDerecha()   = derecha.siguientePosicion(position)   // Solo para testear.
}