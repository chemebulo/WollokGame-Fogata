import protagonista.*
import visualesExtra.*
import npcEstados.*
import npcAtaques.*
import eventos.*
import videojuego.*
import escenariosManager.*
import puertas.*

class Enemigo inherits VisualConMovimiento(position = game.at(5,5)){
    var property estadoCombate
    var property estado        = new EstadoVivo(visual = self) // Describe el estado del enemigo. Por defecto, está vivo.
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
        // Actualiza el estado del enemigo a muerto, cambiando su imagen y su estado de colisión (sumado a unas cuantas cosas más).
        super()
        estado = new EstadoMuerto()
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

    method accionesAdicionalesAlMorir(){}

    method sonidoMuerte() // Describe el sonido de muerte del enemigo.
}

// ################################################################################################################# \\

class Lobo inherits Enemigo(image = "lobo-derecha.png", estadoCombate = new EstadoAgresivoLobo(imagen = image, visual = self, modoAtaque = new AtaqueEnLugar(atacante = self)), vida = 20, daño = 2){
    const property eventoPersecucion = new EventoEnemigoPersecucion(sujetoUnico = self)
    const property eventoAtaque      = new EventoEnemigoAtaque(sujetoUnico = self)

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
    const bloquePostMuerte = bloqueAccionesMuerte
    
    // ============================================================================================================== \\

    override method imagenNueva(direccion){
        // Describe la imagen nueva del lobo en base a la dirección dada.
        return "lobo-jefe-"+direccion.toString()+".png"
    }

    override method sonidoMuerte(){
        // Describe el sonido de muerte del lobo especial.
        return track_loboJefe_derrotado
    }
   
    override method accionesAdicionalesAlMorir(){    
        bloquePostMuerte.apply(self, puertaGranero, self.sonidoMuerte())
    }
}

// ################################################################################################################# \\

object guardabosques inherits Enemigo(image = "guardabosques-cabaña.png", estadoCombate = agresivoGuardabosques, vida = 50, daño = 2){
    var property soyAtravesable = false
    const bloquePostMuerte      = bloqueAccionesMuerte

    // ============================================================================================================== \\

    override method imagenNueva(direccion){ 
        // Describe la imagen nueva del guardabosques en base a la dirección dada.
        return estadoCombate.actual()+direccion.toString()+".png"
    }

    override method accionesAdicionalesAlMorir(){
        self.estadoCombate(pasivoGuardabosques)       
        game.sound(track_guardabosques_derrotado).play() // por ahora vemos que sucede, esto se va a refactorizar
        bloquePostMuerte.apply(self, puertaEntradaCueva, self.sonidoMuerte())
    }
  
    override method sonidoMuerte(){
        // Describe el sonido de muerte del guardabosques.
        return track_guardabosques_muerte
    }

    override method esAtravesable(){
        return soyAtravesable
    }
}    

// ################################################################################################################# \\
// BLOQUES DE MUERTE PARA JEFES

const bloqueAccionesMuerte = {enemigo, salida, ost => enemigo.escenarioDondeEstoy().bajarVolumen();
                                                      game.sound(ost).play()
                                                      game.addVisual(salida)}

// ################################################################################################################# \\