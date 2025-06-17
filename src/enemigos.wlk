import protagonista.*
import visualesExtra.*
import npcEstados.*
import eventos.*
import videojuego.*
import musica.*

class Enemigo inherits VisualConMovimiento(position = game.at(5,5)){
    var property estadoCombate 
    var property estado        = new EnemigoVivo(visual = self) // Describe el estado del enemigo. Por defecto, está vivo.
    const property enemigo     = protagonista  // Describe el enemigo que tiene el enemigo (el protagonista).

    // ============================================================================================================== \\

    method perseguirEnemigo(){
        // El enemigo persigue a su enemigo hasta estar sobre él para poder atacarlo dependiendo de su estado.
        estado.perseguirEnemigo()
    }

    override method atacadoPor(visual){
        // Representa el comportamiento del enemigo cuando un enemigo suyo lo ataca.
        estado.atacadoPor(visual)
    }

    override method actualizarAMuerto(){
        // Actualiza el estado del enemigo a muerto y además modifica la imagen del enemigo.
        super()
        game.schedule(1, {game.sound(self.sonidoMuerte()).play()})
        estado = new EnemigoMuerto()
        image = self.imagenMuerto()
    }

    method estaSobreEnemigo(){
        // Indica si el enemigo se encuentra sobre su enemigo o no.
        return self.position() == enemigo.position()
    }

    override method esAtravesable(){
        // Indica si el enemigo si tiene colisión o no. En este caso describe que tiene colisión (salvo por su enemigo).
        return false
    }

    method atacarEnemigo(){
        // Representa el comportamiento del ataque del enemigo hacia su enemigo.
        estado.atacarEnemigo()
    }

    method puedeAtacarAlEnemigo(){
        // Indica si el enemigo puede atacar a su enemigo. 
        return estado.puedeAtacarAlEnemigo()
    }

    method escenarioDondeEstoy(){
        // Describe el escenario donde actualmente está el enemigo.
        return videojuego.escenario()
    }

    method sonidoMuerte() // Describe el sonido de muerte del enemigo.
}

// ################################################################################################################# \\

class Lobo inherits Enemigo(image = "lobo-derecha.png", estadoCombate = new Agresivo(pj = self), vida = 10, daño = 1){ 
    const property eventoLobo = new EventoLobo(loboEv = self)

    // ============================================================================================================== \\
      
    override method imagenNueva(direccion){
        // Describe la imagen nueva del lobo en base a la dirección dada.
        return "lobo-"+direccion.toString()+".png"
    }

    override method sonidoMuerte(){
        // Describe el sonido de muerte del lobo.
        return sonidosMuerteLobo.anyOne()
    }

    method emitirSonidoEnojado(){
        // Emite un sonido de enojo del lobo.
        game.sound("lobo-enojado.mp3").play()
    }
}

// ################################################################################################################# \\

object loboEspecial inherits Lobo(vida = 30){

    override method actualizarAMuerto(){ 
        // Actualiza el estado del lobo especial a muerto y emite una musica de victoria.
        super()
        game.schedule(1, {self.escenarioDondeEstoy().bajarVolumen()})
    }

    override method sonidoMuerte(){
        // Describe el sonido de muerte del lobo especial.
        return track_loboJefe_derrotado
    }
}

// ################################################################################################################# \\

object guardabosques inherits Enemigo(image = "guardabosques-cabaña.png", estadoCombate = desarmadoGuardabosques, vida = 40, daño = 2){
    
    override method imagenNueva(direccion){ 
        // Describe la imagen nueva del guardabosques en base a la dirección dada.
        return estadoCombate.actual()+direccion.toString()+".png"
    }

    override method actualizarAMuerto(){ 
        // Actualiza el estado del guardabosques a muerto y emite una musica de victoria.
        super()
        game.schedule(1, {self.escenarioDondeEstoy().bajarVolumen();
                          game.sound(track_loboJefe_derrotado).play()})
    }
    
    override method sonidoMuerte(){
        // Describe el sonido de muerte del guardabosques.
        return track_guardabosques_muerte
    }
}    

// ################################################################################################################# \\