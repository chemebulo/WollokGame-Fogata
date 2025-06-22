import protagonista.*
import visualesExtra.*
import npcEstados.*
import eventos.*
import videojuego.*
import escenariosManager.*
import puertas.*

class Enemigo inherits VisualConMovimiento(position = game.at(5,5)){
    var property estado    = new EnemigoVivo(visual = self) // Describe el estado del enemigo. Por defecto, está vivo.
    const property enemigo = protagonista  // Describe el enemigo que tiene el enemigo (el protagonista).

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
        estado = new EnemigoMuerto()
        image = self.imagenMuerto()
        self.cambiarAAtravesable()
        game.sound(self.sonidoMuerte()).play()
        self.accionesAdicionalesAlMorir()
    }

    method estaSobreEnemigo(){
        // Indica si el enemigo se encuentra sobre su enemigo o no.
        return self.position() == enemigo.position()
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

    method accionesAdicionalesAlMorir(){ 
        // Acciones que el enemigo realizaría en caso que necesite hacer después de morir. Solo lo usan el guardabosques y lobo jefe.
        self.escenarioDondeEstoy().bajarVolumen()
        game.sound(track_loboJefe_derrotado).play()
    } 

    method sonidoMuerte() // Describe el sonido de muerte del enemigo.
}

// ################################################################################################################# \\

class Lobo inherits Enemigo(image = "lobo-derecha.png", vida = 20, daño = 2){ 
    const property eventoPersecucion = new EventoLoboPersecucion(sujetoUnico = self)
    const property eventoAtaque      = new EventoLoboAtaque(sujetoUnico = self)

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

object loboEspecial inherits Lobo(image = "lobo-jefe-derecha.png", vida = 50, daño = 5){

    override method imagenNueva(direccion){
        // Describe la imagen nueva del lobo en base a la dirección dada.
        return "lobo-jefe-"+direccion.toString()+".png"
    }

    override method sonidoMuerte(){
        // Describe el sonido de muerte del lobo especial.
        return track_loboJefe_derrotado
    }

    override method accionesAdicionalesAlMorir(){
        super()
        game.addVisual(puertaGranero)
    }
}

// ################################################################################################################# \\

object guardabosques inherits Enemigo(image = "guardabosques-cabaña.png", vida = 50, daño = 2){
    var property estadoCombate = armadoGuardabosques //CAMBIAR DESPUES
    var property soyAtravesable = false // por un tema particular existe esta variable xd

    override method imagenNueva(direccion){ 
        // Describe la imagen nueva del guardabosques en base a la dirección dada.
        return estadoCombate.actual()+direccion.toString()+".png"
    }

    override method accionesAdicionalesAlMorir(){
        super()
        self.estadoCombate(desarmadoGuardabosques)
        game.addVisual(puertaEntradaCueva)
    }
    
    override method sonidoMuerte(){
        // Describe el sonido de muerte del guardabosques.
        return track_guardabosques_muerte
    }

    override method atacarEnemigo(){
        // Representa el comportamiento del ataque del enemigo hacia su enemigo.
        
        estadoCombate.atacarEnemigo()
    }

    override method esAtravesable() = soyAtravesable
}    

// ################################################################################################################# \\