import direccion.*
import visualesExtra.*
import npcEstados.*
import videojuego.*
import gestores.*

// ################################################################################################################################## \\

object protagonista inherits VisualConMovimiento(position = game.at(0,0), 
                                                 image = "prota-desarmado-abajo.png", 
                                                 vida = 100, 
                                                 estadoVida = new EstadoVivo(),
                                                 estadoCombate = pasivoProtagonista){
    var property estadoCombateElegido = null // Representa el estado de combate elegido, se utiliza por una situación particular.
   
    // ============================================================================================================================== \\

    method mover(direccion){
        // Mueve al protagonista una celda hacia la dirección dada si puede mover hacia dicha dirección.
        gestorDeMovimiento.mover(direccion, self)
    }

    method atacar(){
        // Representa el comportamiento del ataque del protagonista hacia su enemigo.   
        self.estadoCombate().atacarEnemigo()   
    }

    override method daño(){
        // Describe el daño que causa cada ataque del enemigo dependiendo de su estado de combate.
        return self.estadoCombate().daño()
    }

    override method atacadoPor(visual){
        // Representa el comportamiento del protagonista cuando un enemigo suyo lo ataca.
        self.estadoVida().atacadoPor(self, visual)
    }

    override method actualizarAMuerto(){
        // Actualiza el estado del protagonista a muerto, lo cual implica terminar el juego.
        super()
        videojuego.juegoPerdido()
    }
    
    override method imagenNueva(direccion){
        // Describe la imagen nueva del protagonista en base al estado de combate y a la dirección dada.
        return self.estadoCombate().actual() + direccion.toString() + ".png"
    }

    method estaAlLadoDelNPC(npc){
        // Indica si el protagonista se encuentra al lado del NPC dado.
        return ejeY.estaEnMismoEje(self, npc) and ejeX.estaAlLado(self, npc)
    }

    method mover(direccion, cantidad){
        // Hace que el personaje se mueva la cantidad de veces dada en la direccion dada. Solo se utiliza para testear. 
        (1 .. cantidad).forEach({n => self.mover(direccion)}) 
    }

    method agarrarArma(arma){
        // El protagonista agara el arma dada y cambia su estado de combate en base a la misma.
        self.estadoCombate(arma.nuevoEstado())
        self.estadoCombateElegido(arma.nuevoEstado()) 
    }
}

// ################################################################################################################################## \\